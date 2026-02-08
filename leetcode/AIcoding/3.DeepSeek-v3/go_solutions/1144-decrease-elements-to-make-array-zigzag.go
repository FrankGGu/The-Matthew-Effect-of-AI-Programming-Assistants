func movesToMakeZigzag(nums []int) int {
    res := [2]int{0, 0}
    n := len(nums)
    for i := 0; i < n; i++ {
        left, right := math.MaxInt32, math.MaxInt32
        if i > 0 {
            left = nums[i-1]
        }
        if i < n-1 {
            right = nums[i+1]
        }
        res[i%2] += max(0, nums[i] - min(left, right) + 1)
    }
    return min(res[0], res[1])
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}