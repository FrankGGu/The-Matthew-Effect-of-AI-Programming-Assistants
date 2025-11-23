package main

func minCostToMakeArray(equalizer []int, costs []int) int {
    n := len(equalizer)
    m := len(costs)
    if n == 0 || m == 0 {
        return 0
    }
    dp := make([]int, m)
    for i := 0; i < m; i++ {
        dp[i] = costs[i]
    }
    for i := 1; i < n; i++ {
        newDp := make([]int, m)
        for j := 0; j < m; j++ {
            minCost := int(^uint(0) >> 1)
            for k := 0; k < m; k++ {
                if equalizer[i] == equalizer[i-1] && j == k {
                    continue
                }
                if dp[k] < minCost {
                    minCost = dp[k]
                }
            }
            newDp[j] = minCost + costs[j]
        }
        dp = newDp
    }
    minResult := int(^uint(0) >> 1)
    for _, v := range dp {
        if v < minResult {
            minResult = v
        }
    }
    return minResult
}