package main

func longestNiceSubarray(nums []int) int {
    maxLen := 0
    bitMask := 0
    left := 0

    for right, num := range nums {
        for bitMask&num != 0 {
            bitMask ^= nums[left]
            left++
        }
        bitMask |= num
        if right-left+1 > maxLen {
            maxLen = right - left + 1
        }
    }

    return maxLen
}