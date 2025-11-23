package main

func maxConsecutive(nums []int, k int) int {
    n := len(nums)
    left := 0
    maxLen := 0
    for right := 0; right < n; right++ {
        if nums[right] == 0 {
            k--
        }
        for k < 0 {
            if nums[left] == 0 {
                k++
            }
            left++
        }
        maxLen = max(maxLen, right-left+1)
    }
    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}