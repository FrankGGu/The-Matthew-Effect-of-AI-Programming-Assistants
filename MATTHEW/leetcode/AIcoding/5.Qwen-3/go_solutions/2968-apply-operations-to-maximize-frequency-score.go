package main

func maxFrequencyScore(nums []int, k int) int {
    sort.Ints(nums)
    left := 0
    total := 0
    maxFreq := 0
    for right := 0; right < len(nums); right++ {
        total += nums[right]
        for nums[right]*(right-left+1) > total + k {
            total -= nums[left]
            left++
        }
        maxFreq = max(maxFreq, right-left+1)
    }
    return maxFreq
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}