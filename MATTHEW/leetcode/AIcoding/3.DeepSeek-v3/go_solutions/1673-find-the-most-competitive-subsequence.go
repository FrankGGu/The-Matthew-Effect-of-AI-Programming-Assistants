func mostCompetitive(nums []int, k int) []int {
    stack := make([]int, 0)
    n := len(nums)
    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[i] < stack[len(stack)-1] && len(stack)+n-i-1 >= k {
            stack = stack[:len(stack)-1]
        }
        if len(stack) < k {
            stack = append(stack, nums[i])
        }
    }
    return stack
}