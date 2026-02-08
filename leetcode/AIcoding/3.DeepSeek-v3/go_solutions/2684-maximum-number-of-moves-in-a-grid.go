func maxMoves(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    maxMoves := 0
    for j := n - 2; j >= 0; j-- {
        for i := 0; i < m; i++ {
            maxNext := 0
            for di := -1; di <= 1; di++ {
                ni := i + di
                if ni >= 0 && ni < m && j+1 < n && grid[ni][j+1] > grid[i][j] {
                    if dp[ni][j+1] > maxNext {
                        maxNext = dp[ni][j+1]
                    }
                }
            }
            if maxNext > 0 || j == n-2 {
                dp[i][j] = maxNext + 1
            }
            if dp[i][j] > maxMoves {
                maxMoves = dp[i][j]
            }
        }
    }

    return maxMoves
}