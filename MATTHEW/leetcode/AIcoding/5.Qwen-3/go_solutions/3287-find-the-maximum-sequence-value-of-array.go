package main

func maxSequenceValue(nums []int) int {
    maxVal := 0
    for i := 0; i < len(nums); i++ {
        current := nums[i]
        maxVal = max(maxVal, current)
        for j := i + 1; j < len(nums); j++ {
            current ^= nums[j]
            maxVal = max(maxVal, current)
        }
    }
    return maxVal
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}