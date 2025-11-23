func find132pattern(nums []int) bool {
    n := len(nums)
    if n < 3 {
        return false
    }

    min := make([]int, n)
    min[0] = nums[0]
    for i := 1; i < n; i++ {
        min[i] = min[i-1]
        if nums[i] < min[i] {
            min[i] = nums[i]
        }
    }

    stack := []int{}
    for j := n - 1; j >= 0; j-- {
        if nums[j] > min[j] {
            for len(stack) > 0 && stack[len(stack)-1] <= min[j] {
                stack = stack[:len(stack)-1]
            }
            if len(stack) > 0 && stack[len(stack)-1] < nums[j] {
                return true
            }
            stack = append(stack, nums[j])
        }
    }

    return false
}