func minOperations(nums []int, k int) int64 {
    var operations int64 = 0
    for _, num := range nums {
        if num < k {
            operations += int64(k - num)
        } else if num > k {
            operations += int64(num - k)
        }
    }
    return operations
}