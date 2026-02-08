package leetcode

func validSubarraySize(nums []int, k int) bool {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    for i := 0; i < n; i++ {
        left[i] = -1
        right[i] = n
    }

    stack := []int{} 

    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1] 
            right[j] = i
        }
        if len(stack) > 0 {
            left[i] = stack[len(stack)-1]
        }
        stack = append(stack, i) 
    }

    for i := 0; i < n; i++ {
        width := right[i] - left[i] - 1
        if int64(nums[i]) * int64(width) > int64(k) {
            return true
        }
    }

    return false
}