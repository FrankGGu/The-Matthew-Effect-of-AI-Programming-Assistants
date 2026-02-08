package main

func minIncrements(nums []int, target int) int {
    sort.Ints(nums)
    res := 0
    for i := 0; i < len(nums); i++ {
        if nums[i] > target {
            break
        }
        if nums[i] < target {
            res += target - nums[i]
        }
    }
    return res
}