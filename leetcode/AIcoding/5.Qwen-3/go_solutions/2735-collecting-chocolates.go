package main

func minCostToCollectAllChocolates(collection []int, cost []int) int {
    n := len(collection)
    totalCost := 0
    for i := 0; i < n; i++ {
        if collection[i] == 0 {
            continue
        }
        totalCost += collection[i] * cost[i]
    }
    return totalCost
}