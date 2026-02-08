func minCostSetTime(current int, set int, cost []int) int {
    minCost := int(1e9)
    for h := 0; h < 24; h++ {
        for m := 0; m < 60; m++ {
            totalMinutes := h*60 + m
            if totalMinutes < set {
                continue
            }
            totalCost := 0
            if h > 0 {
                totalCost += cost[1]
            }
            if m > 0 {
                totalCost += cost[2]
            }
            totalCost += cost[0]
            if totalCost < minCost {
                minCost = totalCost
            }
        }
    }
    return minCost
}