func twoCitySchedCost(costs [][]int) int {
    n := len(costs) / 2
    diffs := make([]int, len(costs))
    totalCost := 0

    for i, cost := range costs {
        totalCost += cost[0]
        diffs[i] = cost[1] - cost[0]
    }

    sort.Ints(diffs)

    for i := 0; i < n; i++ {
        totalCost += diffs[i]
    }

    return totalCost
}