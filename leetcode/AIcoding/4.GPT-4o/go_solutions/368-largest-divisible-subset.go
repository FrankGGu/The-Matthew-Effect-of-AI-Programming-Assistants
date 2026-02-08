package main

import "sort"

func largestDivisibleSubset(nums []int) []int {
    if len(nums) == 0 {
        return []int{}
    }

    sort.Ints(nums)
    n := len(nums)
    dp := make([]int, n)
    prev := make([]int, n)
    maxSize, maxIndex := 1, 0

    for i := 0; i < n; i++ {
        dp[i] = 1
        prev[i] = -1
        for j := 0; j < i; j++ {
            if nums[i]%nums[j] == 0 && dp[j]+1 > dp[i] {
                dp[i] = dp[j] + 1
                prev[i] = j
            }
        }
        if dp[i] > maxSize {
            maxSize = dp[i]
            maxIndex = i
        }
    }

    result := []int{}
    for maxIndex != -1 {
        result = append([]int{nums[maxIndex]}, result...)
        maxIndex = prev[maxIndex]
    }

    return result
}