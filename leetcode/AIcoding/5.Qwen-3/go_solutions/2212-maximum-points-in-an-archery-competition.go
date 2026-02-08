package main

func maxPoints(questions []int) int64 {
    n := len(questions)
    dp := make([]int64, n)
    for i := n - 1; i >= 0; i-- {
        if i == n-1 {
            dp[i] = int64(questions[i])
        } else {
            skip := dp[i+1]
            take := int64(questions[i])
            if i+1 < n {
                take += dp[i+1]
            }
            dp[i] = max(skip, take)
        }
    }
    return dp[0]
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}