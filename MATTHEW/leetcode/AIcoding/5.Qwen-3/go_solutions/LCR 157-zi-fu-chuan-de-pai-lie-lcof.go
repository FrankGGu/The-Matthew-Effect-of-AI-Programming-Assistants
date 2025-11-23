package main

func countPairs(n int, x int) int {
    if x == 0 {
        return 0
    }
    var count int
    for i := 1; i <= n; i++ {
        for j := i + 1; j <= n; j++ {
            if i*x == j || j*x == i {
                count++
            }
        }
    }
    return count
}