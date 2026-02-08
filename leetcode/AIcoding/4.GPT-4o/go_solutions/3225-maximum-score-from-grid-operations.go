func maxScore(grid [][]int, operations [][]int) int {
    m, n := len(grid), len(grid[0])
    maxRow, maxCol := make([]int, m), make([]int, n)

    for _, op := range operations {
        maxRow[op[0]]++
        maxCol[op[1]]++
    }

    totalScore := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if maxRow[i] > maxCol[j] {
                totalScore += grid[i][j]
            }
        }
    }

    return totalScore
}