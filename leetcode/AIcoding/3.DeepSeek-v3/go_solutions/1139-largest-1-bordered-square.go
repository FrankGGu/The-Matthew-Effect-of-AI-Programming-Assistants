func largest1BorderedSquare(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    left := make([][]int, m)
    up := make([][]int, m)
    for i := range left {
        left[i] = make([]int, n)
        up[i] = make([]int, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 1 {
                if i == 0 {
                    up[i][j] = 1
                } else {
                    up[i][j] = up[i-1][j] + 1
                }
                if j == 0 {
                    left[i][j] = 1
                } else {
                    left[i][j] = left[i][j-1] + 1
                }
            } else {
                up[i][j] = 0
                left[i][j] = 0
            }
        }
    }

    maxLen := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            minLen := min(left[i][j], up[i][j])
            for k := minLen; k > 0; k-- {
                if left[i - k + 1][j] >= k && up[i][j - k + 1] >= k {
                    if k > maxLen {
                        maxLen = k
                    }
                    break
                }
            }
        }
    }
    return maxLen * maxLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}