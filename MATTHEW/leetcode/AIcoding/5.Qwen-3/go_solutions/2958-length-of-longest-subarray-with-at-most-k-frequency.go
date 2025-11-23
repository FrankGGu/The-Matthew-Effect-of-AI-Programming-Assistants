package main

func longestSubarray(nums []int, k int) int {
    freq := make(map[int]int)
    left := 0
    maxLength := 0

    for right := 0; right < len(nums); right++ {
        freq[nums[right]]++

        for freq[nums[right]] > k {
            freq[nums[left]]--
            left++
        }

        if right-left+1 > maxLength {
            maxLength = right - left + 1
        }
    }

    return maxLength
}