func largestCombination(candidates []int) int {
    maxCount := 0
    for i := 0; i < 30; i++ {
        currentBitSetCount := 0
        for _, num := range candidates {
            if (num >> i) & 1 == 1 {
                currentBitSetCount++
            }
        }
        if currentBitSetCount > maxCount {
            maxCount = currentBitSetCount
        }
    }
    return maxCount
}