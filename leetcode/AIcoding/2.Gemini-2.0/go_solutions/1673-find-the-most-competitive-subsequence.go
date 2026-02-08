func mostCompetitive(nums []int, k int) []int {
    stack := make([]int, 0, k)
    for i := 0; i < len(nums); i++ {
        for len(stack) > 0 && nums[i] < stack[len(stack)-1] && len(nums)-i+len(stack) > k {
            stack = stack[:len(stack)-1]
        }
        if len(stack) < k {
            stack = append(stack, nums[i])
        }
    }
    return stack
}