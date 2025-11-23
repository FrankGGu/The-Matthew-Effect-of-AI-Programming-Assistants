func getMaximumXor(nums []int, maximumBit int) []int {
    max := (1 << maximumBit) - 1
    xor := 0
    res := make([]int, len(nums))
    for i, num := range nums {
        xor ^= num
        res[len(nums)-1-i] = max ^ xor
    }
    return res
}