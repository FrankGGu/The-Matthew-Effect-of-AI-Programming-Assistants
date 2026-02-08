package main

func sumOfSquares(nums []int) int {
    n := len(nums)
    result := 0
    for i := 0; i < n; i++ {
        if i == 0 || i == n-1 {
            result += nums[i] * nums[i]
        }
    }
    return result
}