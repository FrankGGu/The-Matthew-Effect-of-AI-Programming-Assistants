func maxSumNonAdjacent(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    if len(nums) == 1 {
        return nums[0]
    }

    prev1, prev2 := 0, 0
    for _, num := range nums {
        temp := prev1
        prev1 = max(prev1, prev2 + num)
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