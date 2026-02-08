func maxSumMinSum(nums []int, k int) (int, int) {
    n := len(nums)
    if n == 0 || k <= 0 || k > n {
        return 0, 0
    }

    maxSum := -1 << 31
    minSum := 1 << 31 - 1
    currentSum := 0

    for i := 0; i < n; i++ {
        currentSum += nums[i]
        if i >= k-1 {
            if currentSum > maxSum {
                maxSum = currentSum
            }
            if currentSum < minSum {
                minSum = currentSum
            }
            currentSum -= nums[i-k+1]
        }
    }

    return maxSum, minSum
}