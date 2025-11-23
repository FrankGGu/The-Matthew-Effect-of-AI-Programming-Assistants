func maxIncreasingCells(mat [][]int) int {
    rows, cols := len(mat), len(mat[0])
    cells := make([][3]int, 0)

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            cells = append(cells, [3]int{mat[r][c], r, c})
        }
    }

    sort.Slice(cells, func(i, j int) bool {
        return cells[i][0] < cells[j][0]
    })

    dp := make([][]int, rows)
    for i := range dp {
        dp[i] = make([]int, cols)
    }

    result := 0
    for _, cell := range cells {
        val, r, c := cell[0], cell[1], cell[2]
        maxPrev := 0
        if r > 0 {
            maxPrev = max(maxPrev, dp[r-1][c])
        }
        if c > 0 {
            maxPrev = max(maxPrev, dp[r][c-1])
        }
        dp[r][c] = maxPrev + 1
        result = max(result, dp[r][c])
    }

    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}