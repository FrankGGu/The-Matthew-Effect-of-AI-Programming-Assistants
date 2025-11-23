func longestSubarray(nums []int) int {
    left, right, zeroCount, maxLength := 0, 0, 0, 0
    for right < len(nums) {
        if nums[right] == 0 {
            zeroCount++
        }
        for zeroCount > 1 {
            if nums[left] == 0 {
                zeroCount--
            }
            left++
        }
        maxLength = max(maxLength, right-left)
        right++
    }
    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}