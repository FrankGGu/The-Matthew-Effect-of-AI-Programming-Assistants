package main

func isCovered(range_ [][]int, left int, right int) bool {
    covered := make([]bool, 101)
    for _, r := range range_ {
        for i := r[0]; i <= r[1]; i++ {
            covered[i] = true
        }
    }
    for i := left; i <= right; i++ {
        if !covered[i] {
            return false
        }
    }
    return true
}