package main

func constructProductMatrix(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    left := 1
    right := 1
    for i := 0; i < n; i++ {
        result[i] = 1
    }
    for i := 0; i < n; i++ {
        result[i] *= left
        left *= nums[i]
    }
    for i := n - 1; i >= 0; i-- {
        result[i] *= right
        right *= nums[i]
    }
    return result
}