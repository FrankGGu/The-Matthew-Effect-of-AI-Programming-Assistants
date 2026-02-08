package main

func maximumPopulation(people [][]int) int {
    diff := make([]int, 2051)
    for _, p := range people {
        diff[p[0]]++
        diff[p[1]]--
    }
    max := 0
    current := 0
    year := 0
    for i := 0; i < 2051; i++ {
        current += diff[i]
        if current > max {
            max = current
            year = i
        }
    }
    return year
}