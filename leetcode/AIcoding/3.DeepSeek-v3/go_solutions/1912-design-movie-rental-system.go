type MovieRentingSystem struct {
    movies map[int]map[int]int
    rented map[[2]int]bool
    priceMap map[[2]int]int
}

func Constructor(n int, entries [][]int) MovieRentingSystem {
    movies := make(map[int]map[int]int)
    priceMap := make(map[[2]int]int)
    for _, entry := range entries {
        shop, movie, price := entry[0], entry[1], entry[2]
        if _, ok := movies[movie]; !ok {
            movies[movie] = make(map[int]int)
        }
        movies[movie][shop] = price
        priceMap[[2]int{shop, movie}] = price
    }
    return MovieRentingSystem{
        movies: movies,
        rented: make(map[[2]int]bool),
        priceMap: priceMap,
    }
}

func (this *MovieRentingSystem) Search(movie int) []int {
    shops, ok := this.movies[movie]
    if !ok {
        return []int{}
    }
    type shopPrice struct {
        shop int
        price int
    }
    var sp []shopPrice
    for shop, price := range shops {
        if !this.rented[[2]int{shop, movie}] {
            sp = append(sp, shopPrice{shop, price})
        }
    }
    sort.Slice(sp, func(i, j int) bool {
        if sp[i].price == sp[j].price {
            return sp[i].shop < sp[j].shop
        }
        return sp[i].price < sp[j].price
    })
    res := make([]int, 0, 5)
    for i := 0; i < len(sp) && i < 5; i++ {
        res = append(res, sp[i].shop)
    }
    return res
}

func (this *MovieRentingSystem) Rent(shop int, movie int) {
    this.rented[[2]int{shop, movie}] = true
}

func (this *MovieRentingSystem) Drop(shop int, movie int) {
    delete(this.rented, [2]int{shop, movie})
}

func (this *MovieRentingSystem) Report() [][]int {
    var rentedMovies [][3]int
    for key := range this.rented {
        shop, movie := key[0], key[1]
        price := this.priceMap[key]
        rentedMovies = append(rentedMovies, [3]int{shop, movie, price})
    }
    sort.Slice(rentedMovies, func(i, j int) bool {
        if rentedMovies[i][2] == rentedMovies[j][2] {
            if rentedMovies[i][0] == rentedMovies[j][0] {
                return rentedMovies[i][1] < rentedMovies[j][1]
            }
            return rentedMovies[i][0] < rentedMovies[j][0]
        }
        return rentedMovies[i][2] < rentedMovies[j][2]
    })
    res := make([][]int, 0, 5)
    for i := 0; i < len(rentedMovies) && i < 5; i++ {
        res = append(res, []int{rentedMovies[i][0], rentedMovies[i][1]})
    }
    return res
}