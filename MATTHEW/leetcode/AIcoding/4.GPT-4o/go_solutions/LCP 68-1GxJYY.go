func minCost(bouquets []int, k int) int {
    n := len(bouquets)
    if n < k {
        return -1
    }

    sort.Ints(bouquets)
    totalCost := 0
    for i := 0; i < k; i++ {
        totalCost += bouquets[i]
    }
    return totalCost
}