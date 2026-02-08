func matrixScore(grid [][]int) int {
    m, n := len(grid), len(grid[0])

    for i := 0; i < m; i++ {
        if grid[i][0] == 0 {
            for j := 0; j < n; j++ {
                grid[i][j] ^= 1
            }
        }
    }

    for j := 1; j < n; j++ {
        count := 0
        for i := 0; i < m; i++ {
            if grid[i][j] == 1 {
                count++
            }
        }
        if count < m - count {
            for i := 0; i < m; i++ {
                grid[i][j] ^= 1
            }
        }
    }

    res := 0
    for i := 0; i < m; i++ {
        num := 0
        for j := 0; j < n; j++ {
            num = num << 1 | grid[i][j]
        }
        res += num
    }

    return res
}