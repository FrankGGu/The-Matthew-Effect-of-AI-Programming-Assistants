package main

func minCostToReachEveryPosition(cost []int) []int {
    n := len(cost)
    res := make([]int, n)
    for i := 0; i < n; i++ {
        minCost := cost[i]
        for j := 0; j < i; j++ {
            if cost[j] < minCost {
                minCost = cost[j]
            }
        }
        res[i] = minCost
    }
    return res
}