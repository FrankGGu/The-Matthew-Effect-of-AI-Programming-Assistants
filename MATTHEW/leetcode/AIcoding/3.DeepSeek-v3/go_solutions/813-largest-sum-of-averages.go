func largestSumOfAverages(nums []int, k int) float64 {
    n := len(nums)
    prefix := make([]float64, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + float64(nums[i])
    }

    dp := make([][]float64, n+1)
    for i := range dp {
        dp[i] = make([]float64, k+1)
    }

    for i := 1; i <= n; i++ {
        dp[i][1] = prefix[i] / float64(i)
    }

    for j := 2; j <= k; j++ {
        for i := j; i <= n; i++ {
            for m := j-1; m < i; m++ {
                avg := (prefix[i] - prefix[m]) / float64(i - m)
                if dp[m][j-1] + avg > dp[i][j] {
                    dp[i][j] = dp[m][j-1] + avg
                }
            }
        }
    }

    return dp[n][k]
}