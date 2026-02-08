func longestSubarray(nums []int) int {
    left, right, zeros, ans := 0, 0, 0, 0
    for right < len(nums) {
        if nums[right] == 0 {
            zeros++
        }
        for zeros > 1 {
            if nums[left] == 0 {
                zeros--
            }
            left++
        }
        ans = max(ans, right-left)
        right++
    }
    if ans == len(nums) {
        return ans - 1
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}