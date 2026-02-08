package main

func surfaceArea(grid [][]int) int {
    if len(grid) == 0 {
        return 0
    }
    rows, cols := len(grid), len(grid[0])
    area := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if grid[i][j] > 0 {
                area += 2
                for _, d := range [4][2]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} {
                    ni, nj := i+d[0], j+d[1]
                    if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
                        area += max(0, grid[i][j]-grid[ni][nj])
                    } else {
                        area += grid[i][j]
                    }
                }
            }
        }
    }
    return area
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}