func knightProbability(n int, k int, row int, column int) float64 {
    directions := [][]int{
        {-2, -1}, {-1, -2}, {1, -2}, {2, -1},
        {2, 1}, {1, 2}, {-1, 2}, {-2, 1},
    }

    dp := make([][][]float64, k+1)
    for i := range dp {
        dp[i] = make([][]float64, n)
        for j := range dp[i] {
            dp[i][j] = make([]float64, n)
        }
    }

    dp[0][row][column] = 1.0

    for step := 1; step <= k; step++ {
        for r := 0; r < n; r++ {
            for c := 0; c < n; c++ {
                for _, d := range directions {
                    nr, nc := r+d[0], c+d[1]
                    if nr >= 0 && nr < n && nc >= 0 && nc < n {
                        dp[step][r][c] += dp[step-1][nr][nc] / 8.0
                    }
                }
            }
        }
    }

    probability := 0.0
    for r := 0; r < n; r++ {
        for c := 0; c < n; c++ {
            probability += dp[k][r][c]
        }
    }

    return probability
}