func longestSubarray(nums []int) int {
    left, maxLen, zeroCount := 0, 0, 0

    for right := 0; right < len(nums); right++ {
        if nums[right] == 0 {
            zeroCount++
        }

        for zeroCount > 1 {
            if nums[left] == 0 {
                zeroCount--
            }
            left++
        }

        currentLen := right - left
        if currentLen > maxLen {
            maxLen = currentLen
        }
    }

    return maxLen
}