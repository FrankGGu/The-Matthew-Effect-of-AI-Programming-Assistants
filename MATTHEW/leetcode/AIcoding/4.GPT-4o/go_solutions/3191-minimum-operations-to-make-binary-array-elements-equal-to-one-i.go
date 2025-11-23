func minOperations(nums []int) int {
    n := len(nums)
    totalOnes := 0
    for _, num := range nums {
        totalOnes += num
    }
    return n - totalOnes
}