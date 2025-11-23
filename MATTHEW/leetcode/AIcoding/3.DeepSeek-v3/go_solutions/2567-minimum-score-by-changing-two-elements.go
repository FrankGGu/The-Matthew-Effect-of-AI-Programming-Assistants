func minimizeSum(nums []int) int {
    sort.Ints(nums)
    n := len(nums)
    option1 := nums[n-1] - nums[2]
    option2 := nums[n-3] - nums[0]
    option3 := nums[n-2] - nums[1]
    return min(option1, min(option2, option3))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}