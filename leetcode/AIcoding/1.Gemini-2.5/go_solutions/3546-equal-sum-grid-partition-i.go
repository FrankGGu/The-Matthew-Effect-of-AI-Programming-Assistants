func equalSumGridPartition(grid [][]int) bool {
    m := len(grid)
    n := len(grid[0])

    totalSum := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            totalSum +=