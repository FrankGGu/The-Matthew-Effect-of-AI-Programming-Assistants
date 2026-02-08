package main

func minElements(nums []int, target int) int {
    sum := 0
    count := 0
    for i := 0; i < len(nums); i++ {
        sum += nums[i]
        if sum >= target {
            return count
        }
        count++
    }
    return count
}