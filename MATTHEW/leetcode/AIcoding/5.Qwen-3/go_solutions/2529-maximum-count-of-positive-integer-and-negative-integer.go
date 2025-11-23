package main

func maximumCount(nums []int) int {
    negative := 0
    positive := 0
    for _, num := range nums {
        if num < 0 {
            negative++
        } else if num > 0 {
            positive++
        }
    }
    return max(negative, positive)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}