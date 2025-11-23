package main

func maximumDifference(nums []int) int {
    minVal := nums[0]
    maxDiff := -1
    for _, num := range nums[1:] {
        if num > minVal {
            maxDiff = max(maxDiff, num-minVal)
        } else {
            minVal = num
        }
    }
    return maxDiff
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}