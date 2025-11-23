package main

func removEZero(nums []int) int {
    n := len(nums)
    res := 0
    for i := n - 2; i >= 0; i-- {
        if nums[i] > nums[i+1] {
            res++
            nums[i] = nums[i+1]
        }
    }
    return res
}