func minOperations(nums []int, k int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }
    remainder := totalSum % k
    if remainder == 0 {
        return 0
    }
    return 1
}