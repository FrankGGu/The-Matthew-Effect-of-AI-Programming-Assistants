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
        if houses[i] == 0 {
            for prevColor := 1; prevColor <= n; prevColor++ {
                for prevBlocks := 1; prevBlocks <= target; prevBlocks++ {
                    if dp[i-1][prevColor][prevBlocks] == inf {
                        continue
                    }
                    for currColor := 1; currColor <= n; currColor++ {
                        newBlocks := prevBlocks
                        if currColor != prevColor {
                            newBlocks++
                        }
                        if newBlocks > target {
                            continue
                        }
                        if dp[i][currColor][newBlocks] > dp[i-1][prevColor][prevBlocks]+cost[i][currColor-1] {
                            dp[i][currColor][newBlocks] = dp[i-1][prevColor][prevBlocks] + cost[i][currColor-1]
                        }
                    }
                }
            }
        } else {
            currColor := houses[i]
            for prevColor := 1; prevColor <= n; prevColor++ {
                for prevBlocks := 1; prevBlocks <= target; prevBlocks++ {
                    if dp[i-1][prevColor][prevBlocks] == inf {
                        continue
                    }
                    newBlocks := prevBlocks
                    if currColor != prevColor {
                        newBlocks++
                    }
                    if newBlocks > target {
                        continue
                    }
                    if dp[i][currColor][newBlocks] > dp[i-1][prevColor][prevBlocks] {
                        dp[i][currColor][newBlocks] = dp[i-1][prevColor][prevBlocks]
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