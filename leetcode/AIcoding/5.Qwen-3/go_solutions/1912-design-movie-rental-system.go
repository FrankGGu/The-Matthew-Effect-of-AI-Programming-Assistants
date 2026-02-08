package main

type MovieRentalSystem struct {
    inventory map[int][]int
    rented    map[int]bool
    prices    map[int]int
}

func Constructor() MovieRentalSystem {
    return MovieRentalSystem{
        inventory: make(map[int][]int),
        rented:    make(map[int]bool),
        prices:    make(map[int]int),
    }
}

func (this *MovieRentalSystem) rent(movie int, user int) {
    if this.rented[movie] {
        return
    }
    this.rented[movie] = true
}

func (this *MovieRentalSystem) drop(movie int, user int) {
    if !this.rented[movie] {
        return
    }
    this.rented[movie] = false
}

func (this *MovieRentalSystem) report() []int {
    result := []int{}
    for movie := range this.rented {
        if this.rented[movie] {
            result = append(result, movie)
        }
    }
    return result
}