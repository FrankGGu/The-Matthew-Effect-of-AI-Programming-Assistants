package main

func new21Game(hint int, k int) int {
    if k == 0 {
        return 1
    }
    dp := make([]int, k+1)
    dp[0] = 1
    sum := 1
    for i := 1; i <= k; i++ {
        dp[i] = sum
        if i < hint {
            sum += dp[i]
        } else {
            sum -= dp[i - hint]
        }
    }
    return dp[k]
}