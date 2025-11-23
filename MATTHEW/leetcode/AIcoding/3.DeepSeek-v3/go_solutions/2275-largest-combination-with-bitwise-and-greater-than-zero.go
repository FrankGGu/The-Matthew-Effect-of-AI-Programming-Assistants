func largestCombination(candidates []int) int {
    maxCount := 0
    for i := 0; i < 32; i++ {
        count := 0
        mask := 1 << i
        for _, num := range candidates {
            if num & mask != 0 {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
        }
    }
    return maxCount
}