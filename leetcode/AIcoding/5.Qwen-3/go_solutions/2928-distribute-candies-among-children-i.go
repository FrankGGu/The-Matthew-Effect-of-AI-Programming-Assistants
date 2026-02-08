package main

func distributeCandies(n int, limit int) int {
    var count int
    for i := 0; i <= limit && i <= n; i++ {
        for j := 0; j <= limit && i+j <= n; j++ {
            k := n - i - j
            if k >= 0 && k <= limit {
                count++
            }
        }
    }
    return count
}