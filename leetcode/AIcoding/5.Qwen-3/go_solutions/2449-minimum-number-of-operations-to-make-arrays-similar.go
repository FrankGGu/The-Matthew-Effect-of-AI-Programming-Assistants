package main

func minOperations(nums []int, target []int) int {
    if len(nums) != len(target) {
        return -1
    }
    var ops int
    for i := 0; i < len(nums); i++ {
        if nums[i] == target[i] {
            continue
        }
        if nums[i] > target[i] {
            ops += (nums[i] - target[i]) / 2
        } else {
            ops += (target[i] - nums[i]) / 2
        }
    }
    return ops
}