func minCost(houses []int, cost [][]int, m int, n int, target int) int {
    const inf = 1 << 30
    dp := make([][][]int, m)
    for i := range dp {
        dp[i] = make([][]int, n+1)
        for j := range dp[i] {
            dp[i][j] = make([]int, target+1)
            for k := range dp[i][j] {
                dp[i][j][k] = inf
            }
        }
    }

    if houses[0] == 0 {
        for color := 1; color <= n; color++ {
            dp[0][color][1] = cost[0][color-1]
        }
    } else {
        dp[0][houses[0]][1] = 0
    }

    for i := 1; i < m; i++ {
        for prevColor := 1; prevColor <= n; prevColor++ {
            for blocks := 1; blocks <= target; blocks++ {
                if dp[i-1][prevColor][blocks] == inf {
                    continue
                }
                if houses[i] == 0 {
                    for currColor := 1; currColor <= n; currColor++ {
                        newBlocks := blocks
                        if currColor != prevColor {
                            newBlocks++
                        }
                        if newBlocks > target {
                            continue
                        }
                        newCost := dp[i-1][prevColor][blocks] + cost[i][currColor-1]
                        if newCost < dp[i][currColor][newBlocks] {
                            dp[i][currColor][newBlocks] = newCost
                        }
                    }
                } else {
                    currColor := houses[i]
                    newBlocks := blocks
                    if currColor != prevColor {
                        newBlocks++
                    }
                    if newBlocks > target {
                        continue
                    }
                    newCost := dp[i-1][prevColor][blocks]
                    if newCost < dp[i][currColor][newBlocks] {
                        dp[i][currColor][newBlocks] = newCost
                    }
                }
            }
        }
    }

    res := inf
    for color := 1; color <= n; color++ {
        if dp[m-1][color][target] < res {
            res = dp[m-1][color][target]
        }
    }
    if res == inf {
        return -1
    }
    return res
}