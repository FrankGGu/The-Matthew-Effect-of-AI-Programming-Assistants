func onesMinusZeros(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])

    onesRow := make([]int, m)
    onesCol := make([]int, n)

    for i := 0; i < m; i++ {
        for j := 0; j <