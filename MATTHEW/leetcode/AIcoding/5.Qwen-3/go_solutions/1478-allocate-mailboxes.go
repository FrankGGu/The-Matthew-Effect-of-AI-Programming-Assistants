package main

func minCost(costs []int, houses []int, k int) int {
    n := len(houses)
    if n == 0 {
        return 0
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }
    dp[0][0] = 0

    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            if dp[i-1][j-1] == -1 {
                continue
            }
            minCost := -1
            for l := i; l >= 1; l-- {
                if houses[l-1] != houses[i-1] {
                    break
                }
                cost := 0
                for m := l; m < i; m++ {
                    cost += costs[m]
                }
                if dp[l-1][j-1] == -1 {
                    continue
                }
                if minCost == -1 || dp[l-1][j-1]+cost < minCost {
                    minCost = dp[l-1][j-1] + cost
                }
            }
            dp[i][j] = minCost
        }
    }

    res := -1
    for i := 0; i <= k; i++ {
        if dp[n][i] != -1 && (res == -1 || dp[n][i] < res) {
            res = dp[n][i]
        }
    }
    return res
}