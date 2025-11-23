package main

func minOperations(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }
    res := 0
    for i := n - 2; i >= 0; i-- {
        if nums[i] > nums[i+1] {
            res++
            nums[i] = nums[i+1]
        }
    }
    return res
}