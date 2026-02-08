func getMaximumConsecutive(coins []int) int {
    sort.Ints(coins)
    max := 0
    for _, coin := range coins {
        if coin > max+1 {
            break
        }
        max += coin
    }
    return max + 1
}