package main

func corneredPath(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxZeros := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] != 0 {
                continue
            }

            count := 0

            // Top to current
            for x := i - 1; x >= 0; x-- {
                if grid[x][j] == 0 {
                    count++
                } else {
                    break
                }
            }

            // Left to current
            for y := j - 1; y >= 0; y-- {
                if grid[i][y] == 0 {
                    count++
                } else {
                    break
                }
            }

            // Right to current
            for y := j + 1; y < n; y++ {
                if grid[i][y] == 0 {
                    count++
                } else {
                    break
                }
            }

            // Bottom to current
            for x := i + 1; x < m; x++ {
                if grid[x][j] == 0 {
                    count++
                } else {
                    break
                }
            }

            maxZeros = max(maxZeros, count)
        }
    }

    return maxZeros
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}