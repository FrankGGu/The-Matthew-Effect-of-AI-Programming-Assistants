package main

func minOperations(nums []int, target []int) int {
    if len(nums) != len(target) {
        return -1
    }
    diff := make([]int, len(nums))
    for i := 0; i < len(nums); i++ {
        diff[i] = nums[i] - target[i]
    }

    operations := 0
    for i := 0; i < len(diff); i++ {
        if diff[i] == 0 {
            continue
        }
        if i+1 < len(diff) && diff[i+1] != 0 {
            if diff[i] > 0 {
                diff[i+1] += diff[i]
            } else {
                diff[i+1] -= diff[i]
            }
            operations++
        } else {
            return -1
        }
    }
    return operations
}