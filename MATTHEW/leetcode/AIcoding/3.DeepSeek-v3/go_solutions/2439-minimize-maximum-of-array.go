func minimizeArrayValue(nums []int) int {
    sum := 0
    res := 0
    for i := 0; i < len(nums); i++ {
        sum += nums[i]
        res = max(res, (sum + i) / (i + 1))
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}