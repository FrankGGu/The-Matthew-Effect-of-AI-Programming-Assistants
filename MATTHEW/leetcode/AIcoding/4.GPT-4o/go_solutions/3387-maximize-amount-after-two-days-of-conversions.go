func maxAmount(transactions []int) int {
    n := len(transactions)
    if n == 0 {
        return 0
    }
    if n == 1 {
        return transactions[0]
    }

    dp := make([]int, n)
    dp[0] = transactions[0]
    dp[1] = max(transactions[0], transactions[1])

    for i := 2; i < n; i++ {
        dp[i] = max(dp[i-1], dp[i-2] + transactions[i])
    }

    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}