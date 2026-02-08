package main

func isMajorityElement(nums []int, target int) bool {
    count := 0
    for _, num := range nums {
        if num == target {
            count++
        }
    }
    return count > len(nums)/4
}