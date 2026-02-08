package main

func maxSideLength(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxSide := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                maxSide = max(maxSide, 1)
                for k := 1; i+k < m && j+k < n; k++ {
                    if grid[i+k][j] == 1 && grid[i][j+k] == 1 && grid[i+k][j+k] == 1 {
                        valid := true
                        for l := 1; l < k; l++ {
                            if grid[i+l][j+k] != 1 || grid[i+k][j+l] != 1 {
                                valid = false
                                break
                            }
                        }
                        if valid {
                            maxSide = max(maxSide, k+1)
                        }
                    } else {
                        break
                    }
                }
            }
        }
    }
    return maxSide
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}