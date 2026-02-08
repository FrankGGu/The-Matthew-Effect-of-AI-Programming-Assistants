func shortestSupersequence(nums1 []int, nums2 []int) int {
    n, m := len(nums1), len(nums2)
    dp := make([]int, m+1)

    for i := 1; i <= n; i++ {
        prev := dp[0]
        for j := 1; j <= m; j++ {
            temp := dp[j]
            if nums1[i-1] == nums2[j-1] {
                dp[j] = prev + 1
            } else {
                dp[j] = max(dp[j], dp[j-1])
            }
            prev = temp
        }
    }

    return n + m - dp[m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}