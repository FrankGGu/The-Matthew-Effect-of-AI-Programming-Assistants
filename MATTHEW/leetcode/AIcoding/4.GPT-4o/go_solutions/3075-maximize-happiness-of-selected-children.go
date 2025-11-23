func maxHappiness(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, k+1)

    for i := 0; i < n; i++ {
        for j := k; j > 0; j-- {
            dp[j] = max(dp[j], dp[j-1]+arr[i])
        }
    }

    return dp[k]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}