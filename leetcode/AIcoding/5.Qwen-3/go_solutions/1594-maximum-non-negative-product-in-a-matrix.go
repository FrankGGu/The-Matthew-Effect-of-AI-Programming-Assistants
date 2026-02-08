package main

func maxNonNegativeProduct(matrix [][]int) int {
    m, n := len(matrix), len(matrix[0])
    type pair struct {
        maxVal int
        minVal int
    }
    dp := make([][]pair, m)
    for i := range dp {
        dp[i] = make([]pair, n)
    }

    dp[0][0] = pair{matrix[0][0], matrix[0][0]}
    for j := 1; j < n; j++ {
        dp[0][j] = pair{dp[0][j-1].maxVal * matrix[0][j], dp[0][j-1].minVal * matrix[0][j]}
    }
    for i := 1; i < m; i++ {
        dp[i][0] = pair{dp[i-1][0].maxVal * matrix[i][0], dp[i-1][0].minVal * matrix[i][0]}
    }

    for i := 1; i < m; i++ {
        for j := 1; j < n; j++ {
            a, b, c, d := dp[i-1][j].maxVal*matrix[i][j], dp[i-1][j].minVal*matrix[i][j], dp[i][j-1].maxVal*matrix[i][j], dp[i][j-1].minVal*matrix[i][j]
            dp[i][j].maxVal = max(max(a, b), max(c, d))
            dp[i][j].minVal = min(min(a, b), min(c, d))
        }
    }

    return dp[m-1][n-1].maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}