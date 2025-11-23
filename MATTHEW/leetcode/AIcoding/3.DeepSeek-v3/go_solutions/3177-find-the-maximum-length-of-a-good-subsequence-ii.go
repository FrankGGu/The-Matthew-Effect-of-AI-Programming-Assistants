func maximumLength(nums []int, k int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = 1
        }
    }

    maxLen := 1

    for i := 1; i < n; i++ {
        for j := 0; j <= k; j++ {
            for l := 0; l < i; l++ {
                if nums[l] == nums[i] {
                    if dp[l][j]+1 > dp[i][j] {
                        dp[i][j] = dp[l][j] + 1
                    }
                } else if j > 0 {
                    if dp[l][j-1]+1 > dp[i][j] {
                        dp[i][j] = dp[l][j-1] + 1
                    }
                }
            }
            if dp[i][j] > maxLen {
                maxLen = dp[i][j]
            }
        }
    }

    return maxLen
}