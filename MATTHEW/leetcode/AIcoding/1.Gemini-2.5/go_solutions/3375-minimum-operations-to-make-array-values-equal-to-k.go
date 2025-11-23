func minOperations(nums []int, k int) int {
    operations := 0
    for _, num := range nums {
        if num > k {
            operations += num - k
        } else {
            operations += k - num
        }
    }
    return operations
}