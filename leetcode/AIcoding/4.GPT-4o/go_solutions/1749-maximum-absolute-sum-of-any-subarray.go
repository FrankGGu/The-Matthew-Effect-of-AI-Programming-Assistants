func maxAbsoluteSum(nums []int) int {
    maxSum, minSum, currentMax, currentMin := 0, 0, 0, 0
    for _, num := range nums {
        currentMax = max(currentMax+num, num)
        currentMin = min(currentMin+num, num)
        maxSum = max(maxSum, currentMax)
        minSum = min(minSum, currentMin)
    }
    return max(maxSum, -minSum)
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