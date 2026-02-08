func maximumAndMinimumSums(nums []int, k int) []int64 {
    n := len(nums)
    if n == 0 || k == 0 || k > n {
        return []int64{0, 0}
    }

    maxSum := int64(0)
    minSum := int64(0)

    currentMax := int64(0)
    currentMin := int64(0)

    for i := 0; i < k; i++ {
        currentMax += int64(nums[i])
        currentMin += int64(nums[i])
    }

    maxSum = currentMax
    minSum = currentMin

    for i := k; i < n; i++ {
        currentMax += int64(nums[i]) - int64(nums[i-k])
        currentMin += int64(nums[i]) - int64(nums[i-k])

        if currentMax > maxSum {
            maxSum = currentMax
        }
        if currentMin < minSum {
            minSum = currentMin
        }
    }

    return []int64{maxSum, minSum}
}