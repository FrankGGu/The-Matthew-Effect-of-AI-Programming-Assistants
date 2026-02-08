func minFlips(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }
    flips := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                flips++
            }
        }
    }
    for i := 0; i < n/2; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] != grid[n-i-1][j] {
                flips++
            }
        }
    }
    for j := 0; j < m/2; j++ {
        for i := 0; i < n; i++ {
            if grid[i][j] != grid[i][m-j-1] {
                flips++
            }
        }
    }
    return flips
}