func minimumDeletions(nums []int) int {
    if len(nums) == 1 {
        return 1
    }
    minVal, maxVal := nums[0], nums[0]
    minIdx, maxIdx := 0, 0
    for i, num := range nums {
        if num < minVal {
            minVal = num
            minIdx = i
        }
        if num > maxVal {
            maxVal = num
            maxIdx = i
        }
    }
    left, right := min(minIdx, maxIdx), max(minIdx, maxIdx)
    option1 := right + 1
    option2 := len(nums) - left
    option3 := left + 1 + len(nums) - right
    return min(option1, min(option2, option3))
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