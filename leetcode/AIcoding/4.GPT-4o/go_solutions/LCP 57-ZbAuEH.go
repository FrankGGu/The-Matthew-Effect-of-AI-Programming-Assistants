func longestWorms(w []int) int {
    n := len(w)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = 1
    maxLength := 1

    for i := 1; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if w[i] > w[j] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
        maxLength = max(maxLength, dp[i])
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}