package main

func find132pattern(nums []int) bool {
    stack := []int{}
    third := math.MinInt64
    for i := len(nums) - 1; i >= 0; i-- {
        if nums[i] < third {
            return true
        }
        for len(stack) > 0 && nums[i] > stack[len(stack)-1] {
            third = stack[len(stack)-1]
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, nums[i])
    }
    return false
}