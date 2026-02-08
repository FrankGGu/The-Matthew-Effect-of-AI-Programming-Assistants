package main

func countStudents(nums []int, t int) int {
    for i := 0; i < t; i++ {
        if len(nums) == 0 {
            break
        }
        if nums[0] == 1 {
            nums = nums[1:]
        } else {
            nums = append(nums[1:], nums[0])
        }
    }
    return len(nums)
}