package main

func mostPoints(questions [][]int) int {
    n := len(questions)
    dp := make([]int, n)
    for i := n - 1; i >= 0; i-- {
        take := questions[i][0]
        if i+1 < n {
            take += dp[i+1]
        }
        notTake := 0
        if i+1 < n {
            notTake = dp[i+1]
        }
        dp[i] = max(take, notTake)
    }
    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}