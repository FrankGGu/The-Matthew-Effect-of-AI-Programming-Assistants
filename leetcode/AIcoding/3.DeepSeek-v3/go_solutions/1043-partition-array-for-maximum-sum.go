func maxSumAfterPartitioning(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        maxVal := 0
        for j := 1; j <= k && i-j >= 0; j++ {
            if arr[i-j] > maxVal {
                maxVal = arr[i-j]
            }
            if dp[i-j] + maxVal * j > dp[i] {
                dp[i] = dp[i-j] + maxVal * j
            }
        }
    }
    return dp[n]
}