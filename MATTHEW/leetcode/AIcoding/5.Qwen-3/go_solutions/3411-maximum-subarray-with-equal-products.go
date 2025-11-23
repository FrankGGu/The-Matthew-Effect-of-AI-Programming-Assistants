package main

func maxSubarraySum(nums []int) int {
    maxSum := nums[0]
    currentMax := nums[0]
    currentMin := nums[0]

    for i := 1; i < len(nums); i++ {
        if nums[i] < 0 {
            currentMax, currentMin = currentMin, currentMax
        }
        currentMax = max(nums[i], currentMax*nums[i])
        currentMin = min(nums[i], currentMin*nums[i])
        maxSum = max(maxSum, currentMax)
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