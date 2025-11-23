func longestOnes(nums []int, k int) int {
    left, right := 0, 0
    maxLen := 0
    zeroCount := 0

    for right < len(nums) {
        if nums[right] == 0 {
            zeroCount++
        }

        for zeroCount > k {
            if nums[left] == 0 {
                zeroCount--
            }
            left++
        }

        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
        right++
    }

    return maxLen
}