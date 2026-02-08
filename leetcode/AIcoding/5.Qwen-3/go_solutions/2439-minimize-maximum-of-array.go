package main

func minimizeArrayValue(nums []int) int {
    res := 0
    sum := 0
    for i := 0; i < len(nums); i++ {
        sum += nums[i]
        currentAvg := (sum + i) / (i + 1)
        if currentAvg > res {
            res = currentAvg
        }
    }
    return res
}