func comfortableHumidity(humidity []int) int {
    n := len(humidity)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }

    maxLen := 1

    for i := 1; i < n; i++ {
        for j := 0; j < i; j++ {
            if humidity[i] >= humidity[j] && dp[i] < dp[j]+1 {
                dp[i] = dp[j] + 1
            }
        }
        if dp[i] > maxLen {
            maxLen = dp[i]
        }
    }

    return maxLen
}