func nextGreaterElements(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    stack := []int{}

    for i := 0; i < 2*n; i++ {
        current := nums[i%n]
        for len(stack) > 0 && nums[stack[len(stack)-1]] < current {
            idx := stack[len(stack)-1]
            result[idx] = current
            stack = stack[:len(stack)-1]
        }
        if i < n {
            stack = append(stack, i)
        }
    }

    for i := range result {
        if result[i] == 0 && nums[i] != nums[i] {
            result[i] = -1
        }
    }

    return result
}