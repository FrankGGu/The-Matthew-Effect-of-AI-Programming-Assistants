func deleteGreatestValue(grid [][]int) int {
    total := 0
    for i := 0; i < len(grid); i++ {
        maxVal := 0
        for j := 0; j < len(grid[i]); j++ {
            if grid[i][j] > maxVal {
                maxVal = grid[i][j]
            }
        }
        total += maxVal
        for j := 0; j < len(grid[i]); j++ {
            if grid[i][j] == maxVal {
                grid[i][j] = -1
                break
            }
        }
    }
    return total
}