func pivotGrid(grid [][]int, r int, c int) [][]int {
    m, n := len(grid), len(grid[0])
    if m*n != r*c {
        return [][]int{}
    }

    res := make([][]int, r)
    for i := range res {
        res[i] = make([]int, c)
    }

    for i := 0; i < m*n; i++ {
        res[i/c][i%c] = grid[i/n][i%n]
    }

    return res
}