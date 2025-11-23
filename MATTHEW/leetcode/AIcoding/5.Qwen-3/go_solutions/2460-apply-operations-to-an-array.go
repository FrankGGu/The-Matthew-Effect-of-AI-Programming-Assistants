package main

func applyOperations(nums []int) []int {
    for i := 0; i < len(nums); i++ {
        if nums[i] == 0 {
            continue
        }
        for j := i + 1; j < len(nums); j++ {
            if nums[j] != 0 {
                nums[i], nums[j] = nums[j], nums[i]
                break
            }
        }
    }
    return nums
}