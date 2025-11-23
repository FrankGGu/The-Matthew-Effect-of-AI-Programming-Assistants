type MovieRentalSystem struct {
    movies map[int]int
}

func Constructor() MovieRentalSystem {
    return MovieRentalSystem{movies: make(map[int]int)}
}

func (this *MovieRentalSystem) AddMovie(movieID int, quantity int) {
    this.movies[movieID] += quantity
}

func (this *MovieRentalSystem) RentMovie(movieID int) bool {
    if this.movies[movieID] > 0 {
        this.movies[movieID]--
        return true
    }
    return false
}

func (this *MovieRentalSystem) ReturnMovie(movieID int) {
    this.movies[movieID]++
}