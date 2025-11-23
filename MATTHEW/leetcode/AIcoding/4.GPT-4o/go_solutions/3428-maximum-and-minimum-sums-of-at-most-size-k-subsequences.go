func maxAndMinSums(nums []int, k int) []int64 {
    n := len(nums)
    if k > n {
        return []int64{0, 0}
    }
    sort.Ints(nums)

    minSum := int64(0)
    for i := 0; i < k; i++ {
        minSum += int64(nums[i])
    }

    maxSum := int64(0)
    for i := n - 1; i >= n - k; i-- {
        maxSum += int64(nums[i])
    }

    return []int64{maxSum, minSum}
}