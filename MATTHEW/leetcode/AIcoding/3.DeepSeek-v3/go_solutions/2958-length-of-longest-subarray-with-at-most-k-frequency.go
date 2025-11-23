func maxSubarrayLength(nums []int, k int) int {
    freq := make(map[int]int)
    left := 0
    maxLen := 0

    for right := 0; right < len(nums); right++ {
        freq[nums[right]]++
        for freq[nums[right]] > k {
            freq[nums[left]]--
            left++
        }
        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
    }

    return maxLen
}