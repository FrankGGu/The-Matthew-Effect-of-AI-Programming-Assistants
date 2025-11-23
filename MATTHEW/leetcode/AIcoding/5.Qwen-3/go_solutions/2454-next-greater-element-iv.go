package main

func findFinalValue(nums []int, original int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }
    for seen[original] {
        original++
    }
    return original
}