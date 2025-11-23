package main

func maxPoints(points [][]int) int {
    n := len(points)
    if n == 0 {
        return 0
    }
    m := len(points[0])
    dp := make([]int, m)
    for i := 0; i < n; i++ {
        newDp := make([]int, m)
        for j := 0; j < m; j++ {
            maxVal := 0
            for k := 0; k < m; k++ {
                if k != j {
                    maxVal = max(maxVal, dp[k])
                }
            }
            newDp[j] = maxVal + points[i][j]
        }
        dp = newDp
    }
    maxResult := 0
    for _, v := range dp {
        if v > maxResult {
            maxResult = v
        }
    }
    return maxResult
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}