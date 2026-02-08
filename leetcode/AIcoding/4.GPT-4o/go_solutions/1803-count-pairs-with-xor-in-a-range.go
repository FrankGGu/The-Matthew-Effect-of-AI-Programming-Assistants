package main

import "sort"

func countPairs(nums []int, low int, high int) int {
    sort.Ints(nums)
    count := 0
    n := len(nums)

    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            xor := nums[i] ^ nums[j]
            if xor >= low && xor <= high {
                count++
            }
        }
    }
    return count
}