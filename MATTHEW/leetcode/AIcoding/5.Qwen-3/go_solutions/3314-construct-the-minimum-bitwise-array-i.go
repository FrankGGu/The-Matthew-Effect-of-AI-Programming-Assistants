package main

func minBitwiseArray(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    for i := 0; i < n; i++ {
        minVal := nums[i]
        for j := 0; j < 32; j++ {
            if nums[i]&(1<<j) != 0 {
                candidate := nums[i] ^ (1 << j)
                if candidate < minVal {
                    minVal = candidate
                }
            }
        }
        result[i] = minVal
    }
    return result
}