package main

func sumSquares(nums []int) int {
    n := len(nums)
    result := 0
    for i := 0; i < n; i++ {
        seen := make(map[int]bool)
        for j := i; j < n; j++ {
            if !seen[nums[j]] {
                seen[nums[j]] = true
                result += nums[j] * nums[j]
            }
        }
    }
    return result
}