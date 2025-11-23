package main

func stoneGameIII(stoneValue string) string {
    n := len(stoneValue)
    dp := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        dp[i] = int(stoneValue[i] - '0')
        if i+1 < n {
            dp[i] -= dp[i+1]
        }
        if i+2 < n {
            dp[i] -= dp[i+2]
        }
    }
    if dp[0] > 0 {
        return "Alice"
    } else if dp[0] < 0 {
        return "Bob"
    } else {
        return "Tie"
    }
}