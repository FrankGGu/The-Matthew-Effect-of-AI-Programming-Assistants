func cherryPickup(grid [][]int) int {
    n := len(grid)
    dp := make([][][]int, n)
    for i := range dp {
        dp[i] = make([][]int, n)
        for j := range dp[i] {
            dp[i][j] = make([]int, n)
            for k := range dp[i][j] {
                dp[i][j][k] = -1
            }
        }
    }
    dp[0][0][0] = grid[0][0]

    for x1 := 0; x1 < n; x1++ {
        for y1 := 0; y1 < n; y1++ {
            for x2 := 0; x2 < n; x2++ {
                y2 := x1 + y1 - x2
                if y2 < 0 || y2 >= n || dp[x1][y1][x2] >= 0 {
                    continue
                }
                maxPrev := -1
                dirs := [][]int{{-1, 0}, {0, -1}}
                for _, d1 := range dirs {
                    for _, d2 := range dirs {
                        prevX1, prevY1 := x1+d1[0], y1+d1[1]
                        prevX2, prevY2 := x2+d2[0], y2+d2[1]
                        if prevX1 >= 0 && prevY1 >= 0 && prevX2 >= 0 && prevY2 >= 0 && dp[prevX1][prevY1][prevX2] > maxPrev {
                            maxPrev = dp[prevX1][prevY1][prevX2]
                        }
                    }
                }
                if maxPrev == -1 {
                    continue
                }
                if grid[x1][y1] == -1 || grid[x2][y2] == -1 {
                    continue
                }
                if x1 == x2 && y1 == y2 {
                    dp[x1][y1][x2] = maxPrev + grid[x1][y1]
                } else {
                    dp[x1][y1][x2] = maxPrev + grid[x1][y1] + grid[x2][y2]
                }
            }
        }
    }
    if dp[n-1][n-1][n-1] < 0 {
        return 0
    }
    return dp[n-1][n-1][n-1]
}