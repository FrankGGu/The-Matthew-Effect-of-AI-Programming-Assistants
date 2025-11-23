func minOperationsInventory(n int, orders [][]int) int {
    total := 0
    for _, order := range orders {
        total += order[1]
    }
    return total
}