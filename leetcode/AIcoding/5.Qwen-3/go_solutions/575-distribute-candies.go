package main

func distributeCandies(candyType []int) int {
    uniqueCandies := make(map[int]bool)
    for _, t := range candyType {
        uniqueCandies[t] = true
    }
    return min(len(uniqueCandies), len(candyType)/2)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}