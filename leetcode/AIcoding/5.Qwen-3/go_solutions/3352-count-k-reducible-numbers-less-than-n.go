package main

func countKReducibleNumbers(n int, k int) int {
    if k == 0 {
        return n
    }
    dp := make([]bool, n+1)
    for i := 2; i <= n; i++ {
        if i%k == 0 {
            dp[i] = true
        } else {
            dp[i] = false
        }
    }
    for i := 2; i <= n; i++ {
        if dp[i] {
            for j := i * k; j <= n; j += i * k {
                dp[j] = true
            }
        }
    }
    count := 0
    for i := 1; i <= n; i++ {
        if dp[i] {
            count++
        }
    }
    return count
}