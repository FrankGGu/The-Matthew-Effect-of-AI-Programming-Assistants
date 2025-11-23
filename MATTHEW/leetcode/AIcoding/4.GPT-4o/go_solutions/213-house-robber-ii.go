func rob(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    if len(nums) == 1 {
        return nums[0]
    }

    return max(robRange(nums[:len(nums)-1]), robRange(nums[1:]))
}

func robRange(nums []int) int {
    prev1, prev2 := 0, 0
    for _, num := range nums {
        temp := prev1
        prev1 = max(prev2+num, prev1)
        prev2 = temp
    }
    return prev1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}