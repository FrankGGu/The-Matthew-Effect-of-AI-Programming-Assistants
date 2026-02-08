func minOperations(nums []int, k int) int {
    xorSum := 0
    for _, num := range nums {
        xorSum ^= num
    }
    if xorSum == k {
        return 0
    }
    if len(nums) == 0 {
        return 1
    }
    return 1
}