package main

func sumSubarrayRanges(nums []int) int {
    n := len(nums)
    var result int
    for i := 0; i < n; i++ {
        minVal := nums[i]
        maxVal := nums[i]
        for j := i + 1; j < n; j++ {
            minVal = min(minVal, nums[j])
            maxVal = max(maxVal, nums[j])
            result += maxVal - minVal
        }
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}