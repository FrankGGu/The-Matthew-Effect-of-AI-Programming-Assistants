func maxWidthRamp(nums []int) int {
    stack := []int{}
    n := len(nums)
    for i := 0; i < n; i++ {
        if len(stack) == 0 || nums[i] < nums[stack[len(stack)-1]] {
            stack = append(stack, i)
        }
    }

    maxWidth := 0
    for j := n - 1; j >= 0; j-- {
        for len(stack) > 0 && nums[j] >= nums[stack[len(stack)-1]] {
            width := j - stack[len(stack)-1]
            if width > maxWidth {
                maxWidth = width
            }
            stack = stack[:len(stack)-1]
        }
    }
    return maxWidth
}