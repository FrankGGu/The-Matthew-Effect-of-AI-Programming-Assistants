package main

func moveZeroes(nums []int) {
    nonZeroIndex := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] != 0 {
            nums[nonZeroIndex], nums[i] = nums[i], nums[nonZeroIndex]
            nonZeroIndex++
        }
    }
}