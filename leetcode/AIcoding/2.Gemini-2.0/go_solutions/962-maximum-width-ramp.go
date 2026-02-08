func maxWidthRamp(nums []int) int {
    n := len(nums)
    stack := []int{}
    for i := 0; i < n; i++ {
        if len(stack) == 0 || nums[i] < nums[stack[len(stack)-1]] {
            stack = append(stack, i)
        }
    }

    ans := 0
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && nums[i] >= nums[stack[len(stack)-1]] {
            ans = max(ans, i-stack[len(stack)-1])
            stack = stack[:len(stack)-1]
        }
    }

    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}