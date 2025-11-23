func findLength(nums1 []int, nums2 []int) int {
    n := len(nums1)
    m := len(nums2)
    dp := make([][]int, n + 1)
    for i := range dp {
        dp[i] = make([]int, m + 1)
    }

    maxLength := 0

    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            if nums1[i-1] == nums2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
                if dp[i][j] > maxLength {
                    maxLength = dp[i][j]
                }
            } else {
                dp[i][j] = 0
            }
        }
    }

    return maxLength
}