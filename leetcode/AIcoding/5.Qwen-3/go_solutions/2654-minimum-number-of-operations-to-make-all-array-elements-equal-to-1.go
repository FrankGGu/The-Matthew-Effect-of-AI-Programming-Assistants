package main

func minOperations(nums []int) int {
    count := 0
    for _, num := range nums {
        if num != 1 {
            count++
        }
    }
    return count
}