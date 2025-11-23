func surfaceArea(grid [][]int) int {
    totalArea := 0
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] > 0 {
                totalArea += 2 + grid[i][j]*4
                if i > 0 {
                    totalArea -= min(grid[i][j], grid[i-1][j])
                }
                if j > 0 {
                    totalArea -= min(grid[i][j], grid[i][j-1])
                }
            }
        }
    }
    return totalArea
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}