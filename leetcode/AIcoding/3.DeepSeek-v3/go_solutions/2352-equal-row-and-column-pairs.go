func equalPairs(grid [][]int) int {
    n := len(grid)
    rowMap := make(map[string]int)
    colMap := make(map[string]int)

    for i := 0; i < n; i++ {
        var rowKey strings.Builder
        for j := 0; j < n; j++ {
            rowKey.WriteString(fmt.Sprintf("%d,", grid[i][j]))
        }
        rowMap[rowKey.String()]++
    }

    for j := 0; j < n; j++ {
        var colKey strings.Builder
        for i := 0; i < n; i++ {
            colKey.WriteString(fmt.Sprintf("%d,", grid[i][j]))
        }
        colMap[colKey.String()]++
    }

    count := 0
    for key, val := range rowMap {
        if cnt, exists := colMap[key]; exists {
            count += val * cnt
        }
    }

    return count
}