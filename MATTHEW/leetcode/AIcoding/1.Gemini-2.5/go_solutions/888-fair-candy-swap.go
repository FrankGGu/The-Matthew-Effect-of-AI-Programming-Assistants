func fairCandySwap(aliceSizes []int, bobSizes []int) []int {
    sumA := 0
    for _, size := range aliceSizes {
        sumA += size
    }

    sumB := 0
    bobSet := make(map[int]bool)
    for _, size := range bobSizes {
        sumB += size
        bobSet[size] = true
    }

    diff := (sumB - sumA) / 2

    for _, x := range aliceSizes {
        y := x + diff
        if bobSet[y] {
            return []int{x, y}
        }
    }

    return nil // Should not reach here based on problem constraints
}