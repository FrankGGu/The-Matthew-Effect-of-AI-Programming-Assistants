package main

func knightProbability(n int, k int, row int, column int) float64 {
    directions := [][2]int{{-1, -2}, {-2, -1}, {-2, 1}, {-1, 2}, {1, 2}, {2, 1}, {2, -1}, {1, -2}}
    dp := make([][]float64, n)
    for i := range dp {
        dp[i] = make([]float64, n)
    }
    dp[row][column] = 1.0
    for step := 0; step < k; step++ {
        nextDp := make([][]float64, n)
        for i := range nextDp {
            nextDp[i] = make([]float64, n)
        }
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                if dp[i][j] == 0 {
                    continue
                }
                for _, dir := range directions {
                    ni, nj := i+dir[0], j+dir[1]
                    if ni >= 0 && ni < n && nj >= 0 && nj < n {
                        nextDp[ni][nj] += dp[i][j] / 8.0
                    }
                }
            }
        }
        dp = nextDp
    }
    result := 0.0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            result += dp[i][j]
        }
    }
    return result
}