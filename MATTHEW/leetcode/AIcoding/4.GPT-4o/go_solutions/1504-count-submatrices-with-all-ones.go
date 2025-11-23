func numSubmat(mat [][]int) int {
    if len(mat) == 0 || len(mat[0]) == 0 {
        return 0
    }

    m, n := len(mat), len(mat[0])
    heights := make([][]int, m)
    for i := range heights {
        heights[i] = make([]int, n)
    }

    for j := 0; j < n; j++ {
        for i := 0; i < m; i++ {
            if mat[i][j] == 1 {
                if i == 0 {
                    heights[i][j] = 1
                } else {
                    heights[i][j] = heights[i-1][j] + 1
                }
            }
        }
    }

    count := 0
    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if mat[i][j] == 1 {
                minHeight := heights[i][j]
                for k := j; k >= 0 && mat[i][k] == 1; k-- {
                    minHeight = min(minHeight, heights[i][k])
                    count += minHeight
                }
            }
        }
    }

    return count
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}