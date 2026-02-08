package main

func mostCompetitive(nums []int, k int) []int {
    stack := make([]int, 0)
    n := len(nums)
    for i, num := range nums {
        for len(stack) > 0 && stack[len(stack)-1] > num && len(stack) + n - i > k {
            stack = stack[:len(stack)-1]
        }
        if len(stack) < k {
            stack = append(stack, num)
        }
    }
    return stack
}