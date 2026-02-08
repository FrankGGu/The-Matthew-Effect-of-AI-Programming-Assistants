func maxDotProduct(nums1 []int, nums2 []int) int {
    n, m := len(nums1), len(nums2)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            dp[i][j] = max(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]+nums1[i-1]*nums2[j-1])
        }
    }

    return dp[n][m]
}

func max(a ...int) int {
    maxVal := a[0]
    for _, v := range a {
        if v > maxVal {
            maxVal = v
        }
    }
    return maxVal
}