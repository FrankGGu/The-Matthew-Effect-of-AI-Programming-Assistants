func equalPairs(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])
    rowCount := make(map[string]int)
    pairCount := 0

    for i := 0; i < rows; i++ {
        key := ""
        for j := 0; j < cols; j++ {
            key += fmt.Sprintf("%d,", grid[i][j])
        }
        rowCount[key]++
    }

    for j := 0; j < cols; j++ {
        key := ""
        for i := 0; i < rows; i++ {
            key += fmt.Sprintf("%d,", grid[i][j])
        }
        pairCount += rowCount[key]
    }

    return pairCount
}