package main

func largestCombination(nums []int) int {
    maxCount := 0
    for i := 0; i < 32; i++ {
        count := 0
        for _, num := range nums {
            if (num >> i) & 1 == 1 {
                count++
            }
        }
        if count > maxCount {
            maxCount = count
        }
    }
    return maxCount
}