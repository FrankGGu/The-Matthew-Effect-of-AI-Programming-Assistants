package main

func minCount(coins []int) int {
    count := 0
    for _, coin := range coins {
        count += coin / 2
        if coin % 2 != 0 {
            count++
        }
    }
    return count
}