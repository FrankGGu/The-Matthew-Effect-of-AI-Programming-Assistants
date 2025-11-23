package main

func getColors(n int) []int {
    res := make([]int, n)
    for i := 0; i < n; i++ {
        res[i] = i * 3 + 1
    }
    return res
}