func getMoneyAmount(n int) int {
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    // Iterate over the length of the range (len)
    // len = 1: dp[i