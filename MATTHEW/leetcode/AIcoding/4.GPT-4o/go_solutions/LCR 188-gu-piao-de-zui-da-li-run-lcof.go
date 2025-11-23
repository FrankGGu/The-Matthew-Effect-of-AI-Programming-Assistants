func minCostToMoveChips(chips []int) int {
    oddCount, evenCount := 0, 0
    for _, chip := range chips {
        if chip%2 == 0 {
            evenCount++
        } else {
            oddCount++
        }
    }
    if oddCount < evenCount {
        return oddCount
    }
    return evenCount
}