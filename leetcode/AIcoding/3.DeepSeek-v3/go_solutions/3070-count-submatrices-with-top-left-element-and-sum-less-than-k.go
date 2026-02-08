func countSubmatrices(grid [][]int, k int) int {
    m, n := len(grid), len(grid[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }

    res := 0
    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefix[i][j] = grid[i-1][j-1] + prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]
            if prefix[i][j] <= k {
                res++
            }
        }
    }
    return res
}