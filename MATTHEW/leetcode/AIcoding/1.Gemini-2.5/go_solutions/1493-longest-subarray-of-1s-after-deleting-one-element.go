func longestSubarray(nums []int) int {
    left := 0
    zeroCount := 0
    maxLen := 0

    for right := 0; right < len(nums); right++ {
        if nums[right] == 0 {
            zeroCount++
        }

        for zeroCount > 1 {