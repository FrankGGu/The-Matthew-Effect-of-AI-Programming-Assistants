func minCost(colors string, neededTime []int) int {
    totalCost := 0
    maxCost := 0

    for i := 0; i < len(colors); i++ {
        if i > 0 && colors[i] == colors[i-1] {
            totalCost += min(maxCost, neededTime[i])
            maxCost = max(maxCost, neededTime[i])
        } else {
            maxCost = neededTime[i]
        }
    }

    return totalCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}