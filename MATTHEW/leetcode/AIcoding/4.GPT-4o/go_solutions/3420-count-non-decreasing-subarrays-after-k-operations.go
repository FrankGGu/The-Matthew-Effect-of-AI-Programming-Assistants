func countNonDecreasing(arr []int, k int) int64 {
    n := len(arr)
    dp := make([]int64, n)
    count := int64(0)

    for i := 0; i < n; i++ {
        dp[i] = 1
        if i > 0 && arr[i] >= arr[i-1] {
            dp[i] = dp[i-1] + 1
        }
        if i >= k {
            dp[i] -= dp[i-k]
        }
        count += dp[i]
    }

    return count
}