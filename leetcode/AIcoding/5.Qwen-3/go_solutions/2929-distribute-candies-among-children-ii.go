package main

func distributeCandies(n int, limit int) int {
    var res int
    for i := 0; i <= limit && i <= n; i++ {
        remaining := n - i
        for j := 0; j <= limit && j <= remaining; j++ {
            remaining2 := remaining - j
            for k := 0; k <= limit && k <= remaining2; k++ {
                if remaining2-k >= 0 {
                    res++
                }
            }
        }
    }
    return res
}