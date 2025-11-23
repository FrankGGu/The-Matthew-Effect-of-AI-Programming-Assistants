package main

func hasTrailingZeros(nums []int) bool {
    count := 0
    for _, num := range nums {
        if num&1 == 0 {
            count++
        }
    }
    return count >= 2
}