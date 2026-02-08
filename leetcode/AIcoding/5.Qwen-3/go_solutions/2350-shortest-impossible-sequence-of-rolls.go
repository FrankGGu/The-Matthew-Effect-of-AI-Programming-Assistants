package main

func minImpossibleOR(nums []int) int {
    seen := make(map[int]bool)
    for _, num := range nums {
        seen[num] = true
    }
    for i := 1; i <= 100000; i++ {
        if !seen[i] {
            return i
        }
    }
    return 100001
}