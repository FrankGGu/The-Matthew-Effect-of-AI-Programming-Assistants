package main

func superEggDrop(k int, n int) int {
    dp := make([]int, k)
    for i := 1; i <= n; i++ {
        for j := k - 1; j >= 0; j-- {
            dp[j] = dp[j] + dp[j-1] + 1
            if dp[j] >= n {
                return i
            }
        }
    }
    return n
}