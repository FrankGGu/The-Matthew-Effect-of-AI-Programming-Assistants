func countSubmatrices(grid [][]int, x int, y int) int {
    m, n := len(grid), len(grid[0])
    prefix := make([][]int, m+1)
    for i := range prefix {
        prefix[i] = make([]int, n+1)
    }

    count := 0

    for i := 1; i <= m; i++ {
        for j := 1; j <= n; j++ {
            prefix[i][j] = prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1]
            if grid[i-1][j-1] == x {
                prefix[i][j]++
            } else if grid[i-1][j-1] == y {
                prefix[i][j]--
            }

            if prefix[i][j] == 0 {
                count++
            }
        }
    }

    return count
}