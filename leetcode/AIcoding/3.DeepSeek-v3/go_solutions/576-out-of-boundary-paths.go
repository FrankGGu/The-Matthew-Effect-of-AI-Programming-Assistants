func findPaths(m int, n int, maxMove int, startRow int, startColumn int) int {
    mod := int(1e9 + 7)
    dp := make([][][]int, maxMove+1)
    for i := range dp {
        dp[i] = make([][]int, m)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
        }
    }

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    dp[0][startRow][startColumn] = 1
    result := 0

    for move := 0; move < maxMove; move++ {
        for i := 0; i < m; i++ {
            for j := 0; j < n; j++ {
                if dp[move][i][j] > 0 {
                    for _, dir := range directions {
                        ni, nj := i+dir[0], j+dir[1]
                        if ni >= 0 && ni < m && nj >= 0 && nj < n {
                            dp[move+1][ni][nj] = (dp[move+1][ni][nj] + dp[move][i][j]) % mod
                        } else {
                            result = (result + dp[move][i][j]) % mod
                        }
                    }
                }
            }
        }
    }

    return result
}