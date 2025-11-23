func minOperationsToMakeMedianK(nums []int, k int) int64 {
    sort.Ints(nums)
    n := len(nums)
    medianIndex := n / 2
    var operations int64 = 0

    if nums[medianIndex] == k {
        return 0
    }

    if nums[medianIndex] < k {
        for i := medianIndex; i < n && nums[i] < k; i++ {
            operations += int64(k - nums[i])
        }
    } else {
        for i := medianIndex; i >= 0 && nums[i] > k; i-- {
            operations += int64(nums[i] - k)
        }
    }

    return operations
}