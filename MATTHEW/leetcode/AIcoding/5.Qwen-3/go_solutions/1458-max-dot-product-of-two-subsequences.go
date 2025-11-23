package main

func maxDotProduct(nums1 []int, nums2 []int) int {
    m, n := len(nums1), len(nums2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            dp[i][j] = max(dp[i-1][j-1]+nums1[i-1]*nums2[j-1], dp[i-1][j], dp[i][j-1])
        }
    }
    return dp[m][n]
}

func max(a, b, c int) int {
    if a > b {
        if a > c {
            return a
        } else {
            return c
        }
    } else {
        if b > c {
            return b
        } else {
            return c
        }
    }
}