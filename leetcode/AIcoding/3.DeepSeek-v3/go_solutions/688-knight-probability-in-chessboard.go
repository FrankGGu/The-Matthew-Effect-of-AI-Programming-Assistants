func knightProbability(n int, k int, row int, column int) float64 {
    moves := [][]int{{-2, -1}, {-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}}
    dp := make([][][]float64, k+1)
    for step := 0; step <= k; step++ {
        dp[step] = make([][]float64, n)
        for i := 0; i < n; i++ {
            dp[step][i] = make([]float64, n)
        }
    }
    dp[0][row][column] = 1.0

    for step := 1; step <= k; step++ {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                for _, move := range moves {
                    prevI, prevJ := i - move[0], j - move[1]
                    if prevI >= 0 && prevI < n && prevJ >= 0 && prevJ < n {
                        dp[step][i][j] += dp[step-1][prevI][prevJ] / 8.0
                    }
                }
            }
        }
    }

    res := 0.0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            res += dp[k][i][j]
        }
    }
    return res
}