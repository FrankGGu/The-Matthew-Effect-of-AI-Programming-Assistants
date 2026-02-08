package main

func isIdealWeight(nums []int) bool {
    for i := 0; i < len(nums); i++ {
        if abs(nums[i] - i) > 1 {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}