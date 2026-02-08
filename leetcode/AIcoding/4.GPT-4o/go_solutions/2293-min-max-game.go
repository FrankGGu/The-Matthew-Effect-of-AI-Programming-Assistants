func minMaxGame(nums []int) int {
    for len(nums) > 1 {
        newNums := make([]int, len(nums)/2)
        for i := 0; i < len(newNums); i++ {
            if i%2 == 0 {
                newNums[i] = min(nums[2*i], nums[2*i+1])
            } else {
                newNums[i] = max(nums[2*i], nums[2*i+1])
            }
        }
        nums = newNums
    }
    return nums[0]
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