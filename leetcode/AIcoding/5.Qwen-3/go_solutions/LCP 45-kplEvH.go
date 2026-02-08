package main

func getPoints(ranks []int) []int {
    n := len(ranks)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        count := 0
        for j := 0; j < n; j++ {
            if ranks[j] < ranks[i] {
                count++
            }
        }
        res[i] = count
    }
    return res
}