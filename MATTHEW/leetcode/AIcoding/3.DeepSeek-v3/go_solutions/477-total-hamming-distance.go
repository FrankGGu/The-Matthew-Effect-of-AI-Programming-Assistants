func totalHammingDistance(nums []int) int {
    total := 0
    n := len(nums)
    for i := 0; i < 32; i++ {
        bitCount := 0
        for _, num := range nums {
            bitCount += (num >> i) & 1
        }
        total += bitCount * (n - bitCount)
    }
    return total
}