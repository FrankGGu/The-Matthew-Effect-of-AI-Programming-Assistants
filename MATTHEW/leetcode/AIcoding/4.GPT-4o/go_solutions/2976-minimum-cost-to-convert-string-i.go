func minimumCost(s string, cost []int) int {
    totalCost := 0
    maxCost := 0
    currentSum := 0

    for i := 0; i < len(s); i++ {
        if i > 0 && s[i] != s[i-1] {
            totalCost += currentSum - maxCost
            currentSum = 0
            maxCost = 0
        }
        currentSum += cost[i]
        if cost[i] > maxCost {
            maxCost = cost[i]
        }
    }

    totalCost += currentSum - maxCost

    return totalCost
}