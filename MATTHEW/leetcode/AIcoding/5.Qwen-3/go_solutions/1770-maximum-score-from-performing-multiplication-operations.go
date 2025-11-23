package main

func maximumScore(nums []int, multipliers []int) int {
    n := len(nums)
    m := len(multipliers)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 0; i <= m; i++ {
        for j := 0; j <= m; j++ {
            if i+j > m {
                continue
            }
            if i == 0 && j == 0 {
                dp[i][j] = 0
            } else if i == 0 {
                dp[i][j] = dp[i][j-1] + nums[n-j]*multipliers[j-1]
            } else if j == 0 {
                dp[i][j] = dp[i-1][j] + nums[i-1]*multipliers[i-1]
            } else {
                dp[i][j] = max(dp[i-1][j]+nums[i-1]*multipliers[i+j-1], dp[i][j-1]+nums[n-j]*multipliers[i+j-1])
            }
        }
    }
    maxScore := math.MinInt32
    for i := 0; i <= m; i++ {
        for j := 0; j <= m; j++ {
            if i+j == m {
                if dp[i][j] > maxScore {
                    maxScore = dp[i][j]
                }
            }
        }
    }
    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}