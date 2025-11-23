func islandPerimeter(grid [][]int) int {
    perimeter := 0
    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for i := 0; i < len(grid); i++ {
        for j := 0; j < len(grid[0]); j++ {
            if grid[i][j] == 1 {
                for _, direction := range directions {
                    ni, nj := i + direction[0], j + direction[1]
                    if ni < 0 || ni >= len(grid) || nj < 0 || nj >= len(grid[0]) || grid[ni][nj] == 0 {
                        perimeter++
                    }
                }
            }
        }
    }

    return perimeter
}