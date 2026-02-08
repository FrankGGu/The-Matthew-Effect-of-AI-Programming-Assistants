package main

func maxSubarraySumCircular(nums []int) int {
    total := 0
    maxSum := nums[0]
    currentMax := nums[0]
    minSum := nums[0]
    currentMin := nums[0]

    for i := 1; i < len(nums); i++ {
        total += nums[i]
        currentMax = max(nums[i], currentMax+nums[i])
        maxSum = max(maxSum, currentMax)
        currentMin = min(nums[i], currentMin+nums[i])
        minSum = min(minSum, currentMin)
    }

    if maxSum < 0 {
        return maxSum
    }

    return max(maxSum, total-minSum)
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