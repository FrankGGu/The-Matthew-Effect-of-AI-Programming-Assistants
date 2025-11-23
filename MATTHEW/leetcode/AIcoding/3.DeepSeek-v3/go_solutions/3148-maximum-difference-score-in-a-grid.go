func maxScore(grid [][]int) int {
    m, n := len(grid), len(grid[0])
    maxDiff := make([][]int, m)
    for i := range maxDiff {
        maxDiff[i] = make([]int, n)
    }

    res := -1 << 31

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            minVal := 1 << 31 - 1
            if i > 0 {
                if maxDiff[i-1][j] < minVal {
                    minVal = maxDiff[i-1][j]
                }
            }
            if j > 0 {
                if maxDiff[i][j-1] < minVal {
                    minVal = maxDiff[i][j-1]
                }
            }
            if minVal != 1<<31-1 {
                currentDiff := grid[i][j] - minVal
                if currentDiff > res {
                    res = currentDiff
                }
                maxDiff[i][j] = min(minVal, grid[i][j])
            } else {
                maxDiff[i][j] = grid[i][j]
            }
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