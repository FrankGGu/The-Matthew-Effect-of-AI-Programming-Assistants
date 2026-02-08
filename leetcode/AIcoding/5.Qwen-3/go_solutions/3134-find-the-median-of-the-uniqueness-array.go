package main

func median(ints []int) int {
    unique := make(map[int]bool)
    for _, num := range ints {
        unique[num] = true
    }
    var uniqueSlice []int
    for key := range unique {
        uniqueSlice = append(uniqueSlice, key)
    }
    sort.Ints(uniqueSlice)
    n := len(uniqueSlice)
    if n%2 == 1 {
        return uniqueSlice[n/2]
    }
    return uniqueSlice[n/2-1]
}