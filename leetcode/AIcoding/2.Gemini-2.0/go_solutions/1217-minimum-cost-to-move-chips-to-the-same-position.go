func minCostToMoveChips(position []int) int {
    odd := 0
    even := 0
    for _, p := range position {
        if p%2 == 0 {
            even++
        } else {
            odd++
        }
    }
    if odd < even {
        return odd
    }
    return even
}