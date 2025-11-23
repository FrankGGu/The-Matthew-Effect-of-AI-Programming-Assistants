func longestNiceSubarray(nums []int) int {
    left, mask, maxLen := 0, 0, 0
    for right := 0; right < len(nums); right++ {
        for (mask & nums[right]) != 0 {
            mask ^= nums[left]
            left++
        }
        mask |= nums[right]
        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
    }
    return maxLen
}