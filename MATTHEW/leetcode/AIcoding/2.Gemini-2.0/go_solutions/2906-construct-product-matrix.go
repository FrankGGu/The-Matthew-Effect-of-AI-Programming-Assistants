func constructProductMatrix(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])
    mod := 12345
    result := make([][]int, m)
    for i := range result {
        result[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            product := 1
            for row := 0; row < m; row++ {
                for col := 0; col < n; col++ {
                    if row == i && col == j {
                        continue
                    }
                    product = (product * grid[row][col]) % mod
                }
            }
            result[i][j] = product
        }
    }

    return result
}