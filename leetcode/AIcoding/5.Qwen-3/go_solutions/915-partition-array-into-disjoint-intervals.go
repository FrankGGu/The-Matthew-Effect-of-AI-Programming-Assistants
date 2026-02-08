package main

func partitionDisjoint(nums []int) int {
    maxSoFar := nums[0]
    currentMax := nums[0]
    result := 0
    for i := 1; i < len(nums); i++ {
        if nums[i] < maxSoFar {
            result = i
            maxSoFar = currentMax
        } else {
            currentMax = nums[i]
        }
    }
    return result
}