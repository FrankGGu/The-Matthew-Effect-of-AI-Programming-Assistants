func nextGreaterElements(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }
    stack := make([]int, 0)

    for i := 0; i < 2*n; i++ {
        num := nums[i%n]
        for len(stack) > 0 && nums[stack[len(stack)-1]] < num {
            res[stack[len(stack)-1]] = num
            stack = stack[:len(stack)-1]
        }
        if i < n {
            stack = append(stack, i)
        }
    }

    return res
}