func maxSubarraySumCircular(nums []int) int {
    totalSum := 0
    maxSum := nums[0]
    minSum := nums[0]
    currMax := 0
    currMin := 0

    for _, num := range nums {
        totalSum += num
        currMax = max(currMax+num, num)
        maxSum = max(maxSum, currMax)
        currMin = min(currMin+num, num)
        minSum = min(minSum, currMin)
    }

    if maxSum > 0 {
        return max(maxSum, totalSum-minSum)
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