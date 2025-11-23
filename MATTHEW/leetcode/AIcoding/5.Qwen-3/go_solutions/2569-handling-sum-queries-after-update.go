package main

func sumSubarrayMins(nums []int) int {
    mod := 1000000007
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    stack := []int{}
    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[stack[len(stack)-1]] > nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            left[i] = -1
        } else {
            left[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    stack = []int{}
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    res := 0
    for i := 0; i < n; i++ {
        res += nums[i] * (i - left[i]) * (right[i] - i)
        res %= mod
    }

    return res
}