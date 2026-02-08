func maximumSum(nums []int) int64 {
    n := len(nums)
    maxSum := int64(0)

    for k := 1; k <= n; k++ {
        currentSum := int64(0)
        for i := 1; i*i*k <= n; i++ {
            idx := i*i*k - 1
            currentSum += int64(nums[idx])
        }
        if currentSum > maxSum {
            maxSum = currentSum
        }
    }

    return maxSum
}