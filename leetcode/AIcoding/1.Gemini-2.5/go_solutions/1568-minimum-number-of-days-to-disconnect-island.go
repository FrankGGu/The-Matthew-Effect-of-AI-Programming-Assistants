func minDays(grid [][]int) int {
    rows := len(grid)
    cols := len(grid[0])

    // Helper function to count connected components of '1's
    var countIslands func([][]int) int
    countIslands = func(g [][]int) int {
        r := len(