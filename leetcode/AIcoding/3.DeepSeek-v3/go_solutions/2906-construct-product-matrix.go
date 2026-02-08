func constructProductMatrix(grid [][]int) [][]int {
    m, n := len(grid), len(grid[0])
    mod := 12345
    prefix := make([]int, m*n)
    suffix := make([]int, m*n)

    prefix[0] = 1
    for i := 1; i < m*n; i++ {
        row, col := (i-1)/n, (i-1)%n
        prefix[i] = (prefix[i-1] * grid[row][col]) % mod
    }

    suffix[m*n-1] = 1
    for i := m*n - 2; i >= 0; i-- {
        row, col := (i+1)/n, (i+1)%n
        suffix[i] = (suffix[i+1] * grid[row][col]) % mod
    }

    res := make([][]int, m)
    for i := 0; i < m; i++ {
        res[i] = make([]int, n)
        for j := 0; j < n; j++ {
            idx := i*n + j
            res[i][j] = (prefix[idx] * suffix[idx]) % mod
        }
    }
    return res
}