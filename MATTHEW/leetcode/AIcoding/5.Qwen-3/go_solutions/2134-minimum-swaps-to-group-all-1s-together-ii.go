package main

func minSwaps(nums []int) int {
    n := len(nums)
    totalOnes := 0
    for _, num := range nums {
        if num == 1 {
            totalOnes++
        }
    }
    if totalOnes == 0 || totalOnes == n {
        return 0
    }
    windowSize := totalOnes
    maxOnesInWindow := 0
    currentOnes := 0
    for i := 0; i < windowSize; i++ {
        if nums[i] == 1 {
            currentOnes++
        }
    }
    maxOnesInWindow = currentOnes
    for i := windowSize; i < n; i++ {
        if nums[i] == 1 {
            currentOnes++
        }
        if nums[i-windowSize] == 1 {
            currentOnes--
        }
        if currentOnes > maxOnesInWindow {
            maxOnesInWindow = currentOnes
        }
    }
    return totalOnes - maxOnesInWindow
}