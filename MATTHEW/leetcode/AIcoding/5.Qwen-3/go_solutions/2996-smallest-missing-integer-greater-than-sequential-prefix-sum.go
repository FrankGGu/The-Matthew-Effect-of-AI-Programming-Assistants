package main

func missingInteger(nums []int) int {
    n := len(nums)
    prefix := nums[0]
    for i := 1; i < n; i++ {
        if nums[i] == nums[i-1]+1 {
            prefix += nums[i]
        } else {
            break
        }
    }
    target := prefix + 1
    for i := 0; i < n; i++ {
        if nums[i] == target {
            target++
        }
    }
    return target
}