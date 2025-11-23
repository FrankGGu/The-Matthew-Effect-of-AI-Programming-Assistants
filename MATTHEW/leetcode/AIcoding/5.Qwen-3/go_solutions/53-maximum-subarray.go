package main

func maxSubArray(nums []int) int {
    maxCurrent := nums[0]
    maxGlobal := nums[0]
    for i := 1; i < len(nums); i++ {
        maxCurrent = max(maxCurrent+nums[i], nums[i])
        if maxCurrent > maxGlobal {
            maxGlobal = maxCurrent
        }
    }
    return maxGlobal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}