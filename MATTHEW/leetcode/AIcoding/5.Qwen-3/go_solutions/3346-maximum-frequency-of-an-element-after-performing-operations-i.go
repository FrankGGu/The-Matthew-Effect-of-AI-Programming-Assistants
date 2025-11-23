package main

func maxFrequency(nums []int, k int) int {
    sort.Ints(nums)
    left := 0
    maxFreq := 0
    total := 0
    for right := 0; right < len(nums); right++ {
        total += nums[right]
        for (right - left + 1)*nums[right] - total > k {
            total -= nums[left]
            left++
        }
        maxFreq = max(maxFreq, right - left + 1)
    }
    return maxFreq
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}