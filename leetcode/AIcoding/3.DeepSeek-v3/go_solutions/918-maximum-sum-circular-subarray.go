func maxSubarraySumCircular(nums []int) int {
    total, maxSum, minSum, currMax, currMin := 0, nums[0], nums[0], 0, 0
    for _, num := range nums {
        total += num
        currMax = max(num, currMax+num)
        maxSum = max(maxSum, currMax)
        currMin = min(num, currMin+num)
        minSum = min(minSum, currMin)
    }
    if maxSum > 0 {
        return max(maxSum, total-minSum)
    }
    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}