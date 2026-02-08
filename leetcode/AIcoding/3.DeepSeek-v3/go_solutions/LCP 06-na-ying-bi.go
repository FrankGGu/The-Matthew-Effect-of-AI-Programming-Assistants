func minCount(coins []int) int {
    count := 0
    for _, coin := range coins {
        count += (coin + 1) / 2
    }
    return count
}