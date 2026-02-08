func minimumTimeToRevert(s string, cost []int) int {
    n := len(s)
    totalCost := 0
    for i := 0; i < n; i++ {
        if s[i] == '1' {
            totalCost += cost[i]
        }
    }

    return totalCost
}