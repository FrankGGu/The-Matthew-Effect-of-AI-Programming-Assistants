package main

func minNumber(nums []int) int {
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if nums[i] > nums[j] {
                nums[i], nums[j] = nums[j], nums[i]
            }
        }
    }
    result := 0
    for i := 0; i < len(nums); i += 2 {
        result = result * 10 + nums[i]
    }
    return result
}