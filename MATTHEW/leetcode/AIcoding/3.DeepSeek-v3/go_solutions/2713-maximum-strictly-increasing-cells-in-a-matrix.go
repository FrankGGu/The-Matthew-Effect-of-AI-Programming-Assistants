func maxIncreasingCells(mat [][]int) int {
    m, n := len(mat), len(mat[0])
    type cell struct{ i, j, val int }
    cells := make([]cell, 0, m*n)
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            cells = append(cells, cell{i, j, mat[i][j]})
        }
    }
    sort.Slice(cells, func(i, j int) bool {
        return cells[i].val < cells[j].val
    })

    rowMax := make([]int, m)
    colMax := make([]int, n)
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }

    res := 0
    for i := 0; i < len(cells); {
        j := i
        for j < len(cells) && cells[j].val == cells[i].val {
            j++
        }
        for k := i; k < j; k++ {
            x, y := cells[k].i, cells[k].j
            dp[x][y] = max(rowMax[x], colMax[y]) + 1
            res = max(res, dp[x][y])
        }
        for k := i; k < j; k++ {
            x, y := cells[k].i, cells[k].j
            rowMax[x] = max(rowMax[x], dp[x][y])
            colMax[y] = max(colMax[y], dp[x][y])
        }
        i = j
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}