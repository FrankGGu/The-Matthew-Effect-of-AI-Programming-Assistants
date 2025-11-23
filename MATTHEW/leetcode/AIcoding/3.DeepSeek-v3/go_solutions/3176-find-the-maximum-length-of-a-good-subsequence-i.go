func maximumLength(nums []int, k int) int {
    n := len(nums)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = 1
        }
    }

    res := 1
    for i := 1; i < n; i++ {
        for j := 0; j <= k; j++ {
            for l := 0; l < i; l++ {
                if nums[i] == nums[l] {
                    if dp[i][j] < dp[l][j] + 1 {
                        dp[i][j] = dp[l][j] + 1
                    }
                } else if j > 0 {
                    if dp[i][j] < dp[l][j-1] + 1 {
                        dp[i][j] = dp[l][j-1] + 1
                    }
                }
            }
            if dp[i][j] > res {
                res = dp[i][j]
            }
        }
    }
    return res
}