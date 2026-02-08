package main

func numberOfHouses(streetLength int, k int) int {
    if k == 0 {
        return 1
    }
    if k > streetLength/2 {
        return 0
    }
    return (streetLength - 2*k + 1)
}