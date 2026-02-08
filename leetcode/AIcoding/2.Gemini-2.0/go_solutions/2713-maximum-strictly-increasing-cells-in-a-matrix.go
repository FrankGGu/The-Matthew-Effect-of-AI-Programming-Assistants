func maxIncreasingCells(matrix [][]int) int {
    m, n := len(matrix), len(matrix[0])
    rowMax := make([]int, m)
    colMax := make([]int, n)
    cells := []struct{ row, col, val int }{}
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            cells = append(cells, struct{ row, col, val int }{i, j, matrix[i][j]})
        }
    }
    sort.Slice(cells, func(i, j int) bool {
        return cells[i].val < cells[j].val
    })
    dp := make([][]int, m)
    for i := 0; i < m; i++ {
        dp[i] = make([]int, n)
    }
    ans := 0
    seen := map[int]map[int]bool{}
    for _, cell := range cells {
        r, c, val := cell.row, cell.col, cell.val
        if seen[r] == nil {
            seen[r] = map[int]bool{}
        }
        if seen[r][c] {
            continue
        }
        seen[r][c] = true

        dp[r][c] = 1 + max(rowMax[r], colMax[c])
        rowMax[r] = max(rowMax[r], dp[r][c])
        colMax[c] = max(colMax[c], dp[r][c])
        ans = max(ans, dp[r][c])
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}