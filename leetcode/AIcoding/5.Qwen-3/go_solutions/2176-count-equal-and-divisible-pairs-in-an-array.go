package main

func equalPairs(nums []int) int {
    count := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if nums[i] == nums[j] {
                count++
            }
        }
    }
    return count
}