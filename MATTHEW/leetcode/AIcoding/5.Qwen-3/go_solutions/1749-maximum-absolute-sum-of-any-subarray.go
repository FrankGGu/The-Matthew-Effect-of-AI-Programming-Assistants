package main

func maximumAbsoluteSum(nums []int) int {
    maxSum := 0
    currentMax := 0
    currentMin := 0
    for _, num := range nums {
        currentMax = max(currentMax+num, num)
        currentMin = min(currentMin+num, num)
        maxSum = max(maxSum, abs(currentMax), abs(currentMin))
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

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}