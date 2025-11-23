func connectTwoGroups(cost [][]int) int {
    size1, size2 := len(cost), len(cost[0])
    minCost2 := make([]int, size2)
    for j := 0; j < size2; j++ {
        minVal := cost[0][j]
        for i := 1; i < size1; i++ {
            if cost[i][j] < minVal {
                minVal = cost[i][j]
            }
        }
        minCost2[j] = minVal
    }

    dp := make([]int, 1<<size2)
    for mask := 1; mask < 1<<size2; mask++ {
        dp[mask] = 1 << 31
    }

    for i := 0; i < size1; i++ {
        newDp := make([]int, 1<<size2)
        copy(newDp, dp)
        for mask := 0; mask < 1<<size2; mask++ {
            for j := 0; j < size2; j++ {
                nextMask := mask | (1 << j)
                if newDp[nextMask] > dp[mask]+cost[i][j] {
                    newDp[nextMask] = dp[mask] + cost[i][j]
                }
            }
        }
        dp = newDp
    }

    total := dp[(1<<size2)-1]
    for mask := 0; mask < 1<<size2; mask++ {
        sum := 0
        for j := 0; j < size2; j++ {
            if mask&(1<<j) == 0 {
                sum += minCost2[j]
            }
        }
        if total > dp[mask]+sum {
            total = dp[mask] + sum
        }
    }

    return total
}