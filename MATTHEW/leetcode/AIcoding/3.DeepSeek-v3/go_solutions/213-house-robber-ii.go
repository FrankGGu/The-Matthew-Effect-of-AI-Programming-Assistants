func rob(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    if n == 1 {
        return nums[0]
    }
    return max(robHelper(nums[:n-1]), robHelper(nums[1:]))
}

func robHelper(nums []int) int {
    prev1, prev2 := 0, 0
    for _, num := range nums {
        current := max(prev1, prev2 + num)
        prev2 = prev1
        prev1 = current
    }
    return prev1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}