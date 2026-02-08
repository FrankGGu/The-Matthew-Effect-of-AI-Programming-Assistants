func maxDotProduct(nums1 []int, nums2 []int) int {
    m, n := len(nums1), len(nums2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
        for j := range dp[i] {
            dp[i][j] = -1 << 31
        }
    }

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            product := nums1[i-1] * nums2[j-1]
            dp[i][j] = max(product, max(dp[i-1][j-1]+product, max(dp[i-1][j], dp[i][j-1])))
        }
    }

    return dp[m][n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}