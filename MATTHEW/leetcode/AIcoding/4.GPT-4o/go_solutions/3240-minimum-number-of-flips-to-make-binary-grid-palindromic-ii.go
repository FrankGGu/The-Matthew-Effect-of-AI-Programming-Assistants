func minFlips(grid [][]int) int {
    n := len(grid)
    m := len(grid[0])

    flipCount := make([][]int, n)
    for i := range flipCount {
        flipCount[i] = make([]int, m)
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == 1 {
                flipCount[i][j] = 1
            }
        }
    }

    res := 0
    for i := 0; i < n/2; i++ {
        for j := 0; j < m; j++ {
            res += min(flipCount[i][j], flipCount[n-1-i][j])
        }
    }
    if n%2 == 1 {
        for j := 0; j < m; j++ {
            res += flipCount[n/2][j]
        }
    }

    for j := 0; j < m/2; j++ {
        for i := 0; i < n; i++ {
            res += min(flipCount[i][j], flipCount[i][m-1-j])
        }
    }
    if m%2 == 1 {
        for i := 0; i < n; i++ {
            res += flipCount[i][m/2]
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}