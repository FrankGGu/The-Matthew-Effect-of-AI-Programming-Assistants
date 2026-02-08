func maximumXor(nums []int) int {
    xorResult := 0
    for _, num := range nums {
        xorResult ^= num
    }
    maxPairXor := 0
    for _, num := range nums {
        maxPairXor = max(maxPairXor, xorResult ^ num)
    }
    return maxPairXor
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}