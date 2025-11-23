func differenceOfDistinctValues(grid [][]int) [][]int {
    m := len(grid)
    n := len(grid[0])
    res := make([][]int, m)
    for i := range res {
        res[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            topLeft := make(map[int]bool)
            r, c := i-1, j-1
            for r >= 0 && c >= 0 {
                topLeft[grid[r][c]] = true
                r--
                c--
            }

            bottomRight := make(map[int]bool)
            r, c = i+1, j+1
            for r < m && c < n {
                bottomRight[grid[r][c]] = true
                r++
                c++
            }

            res[i][j] = abs(len(topLeft) - len(bottomRight))
        }
    }

    return res
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}