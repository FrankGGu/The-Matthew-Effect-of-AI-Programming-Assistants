package main

func minSpaceWaster(k int, nums []int) int {
    n := len(nums)
    dp := make([][]int, k+1)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        dp[0][i] = nums[i]
        if i > 0 {
            dp[0][i] += dp[0][i-1]
        }
    }

    for i := 1; i <= k; i++ {
        for j := i; j < n; j++ {
            dp[i][j] = 1 << 63
            for m := i - 1; m < j; m++ {
                current := dp[i-1][m]
                next := dp[0][j] - dp[0][m]
                avg := (next) / (j - m)
                total := next - avg*(j - m)
                dp[i][j] = min(dp[i][j], current+total)
            }
        }
    }

    return dp[k][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}