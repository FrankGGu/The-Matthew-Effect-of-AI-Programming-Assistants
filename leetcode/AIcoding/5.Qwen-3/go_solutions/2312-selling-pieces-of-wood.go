package main

func maxProfit(widths []int, heights []int, isVertical []bool) int {
    n := len(widths)
    m := len(heights)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            if isVertical[i-1] {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]+widths[i-1]*heights[j-1])
            }
        }
    }
    return dp[n][m]
}

func max(nums ...int) int {
    maxVal := nums[0]
    for _, num := range nums[1:] {
        if num > maxVal {
            maxVal = num
        }
    }
    return maxVal
}