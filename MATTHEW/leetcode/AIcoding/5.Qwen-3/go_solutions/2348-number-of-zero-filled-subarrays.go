package main

func numSubarraysWithZeroes(nums []int) int {
    count := 0
    result := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] == 0 {
            count++
        } else {
            count = 0
        }
        result += count
    }
    return result
}