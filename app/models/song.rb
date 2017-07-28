class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  # look up null pointer problem

  def artist_name
  	if self.artist
  		self.artist.name
  	end
  end 


  def genre_name=(name)
    self.genre = Genre.find_by(name: name)
  end

  # look up null pointer problem

  def genre_name
  	if self.genre
  		self.genre.name
  	end
  end 

  def note_contents=(contents)
     contents.each do |text|
       found_note = Note.find_or_create_by(content: text, song_id: self.id)
       self.notes << found_note
     end
   end

   def note_contents
	   	self.notes.map do |note|
	   		note.content
	   	end - ["", nil]
	   	# the above 'subtracts' or removes any empty or nil
   end 

end

