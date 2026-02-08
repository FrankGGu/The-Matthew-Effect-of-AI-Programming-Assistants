package main

func nextGreaterElements(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    stack := []int{}

    for i := 2*n - 1; i >= 0; i-- {
        for len(stack) > 0 && stack[len(stack)-1] <= nums[i%n] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            res[i%n] = -1
        } else {
            res[i%n] = stack[len(stack)-1]
        }
        stack = append(stack, nums[i%n])
    }

    return res
}