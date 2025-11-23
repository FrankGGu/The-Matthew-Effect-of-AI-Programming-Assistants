func orderOfLargestPlusSign(n int, mines [][]int) int {
    grid := make([][]int, n)
    for i := range grid {
        grid[i] = make([]int, n)
        for j := range grid[i] {
            grid[i][j] = 1
        }
    }
    for _, mine := range mines {
        grid[mine[0]][mine[1]] = 0
    }

    left := make([][]int, n)
    right := make([][]int, n)
    up := make([][]int, n)
    down := make([][]int, n)
    for i := 0; i < n; i++ {
        left[i] = make([]int, n)
        right[i] = make([]int, n)
        up[i] = make([]int, n)
        down[i] = make([]int, n)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                if j == 0 {
                    left[i][j] = 1
                } else {
                    left[i][j] = left[i][j-1] + 1
                }
            }
        }
    }

    for i := 0; i < n; i++ {
        for j := n - 1; j >= 0; j-- {
            if grid[i][j] == 1 {
                if j == n-1 {
                    right[i][j] = 1
                } else {
                    right[i][j] = right[i][j+1] + 1
                }
            }
        }
    }

    for j := 0; j < n; j++ {
        for i := 0; i < n; i++ {
            if grid[i][j] == 1 {
                if i == 0 {
                    up[i][j] = 1
                } else {
                    up[i][j] = up[i-1][j] + 1
                }
            }
        }
    }

    for j := 0; j < n; j++ {
        for i := n - 1; i >= 0; i-- {
            if grid[i][j] == 1 {
                if i == n-1 {
                    down[i][j] = 1
                } else {
                    down[i][j] = down[i+1][j] + 1
                }
            }
        }
    }

    maxOrder := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                min := left[i][j]
                if right[i][j] < min {
                    min = right[i][j]
                }
                if up[i][j] < min {
                    min = up[i][j]
                }
                if down[i][j] < min {
                    min = down[i][j]
                }
                if min > maxOrder {
                    maxOrder = min
                }
            }
        }
    }
    return maxOrder
}