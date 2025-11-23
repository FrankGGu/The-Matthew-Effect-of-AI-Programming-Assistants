func projectionArea(grid [][]int) int {
    xy := 0
    xz := 0
    yz := 0
    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] > 0 {
                xy++
            }
            if grid[i][j] > xz {
                xz = grid[i][j]
            }
            if grid[j][i] > yz {
                yz = grid[j][i]
            }
        }
        xz += yz
        yz = 0
    }
    return xy + xz + yz
}