func minFlips(grid [][]int) int {
    n := len(grid)
    res := 0
    for i := 0; i < n/2; i++ {
        for j := 0; j < n/2; j++ {
            cnt := grid[i][j] + grid[i][n-1-j] + grid[n-1-i][j] + grid[n-1-i][n-1-j]
            res += min(cnt, 4-cnt)
        }
    }
    if n%2 == 1 {
        for i := 0; i < n/2; i++ {
            cnt := grid[n/2][i] + grid[n/2][n-1-i]
            res += min(cnt, 2-cnt)
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}