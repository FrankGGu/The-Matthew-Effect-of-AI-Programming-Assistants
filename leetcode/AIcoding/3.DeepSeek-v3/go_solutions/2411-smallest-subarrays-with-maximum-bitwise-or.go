func smallestSubarrays(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    last := make([]int, 32)
    for i := 0; i < 32; i++ {
        last[i] = -1
    }
    for i := n - 1; i >= 0; i-- {
        maxLen := 1
        for j := 0; j < 32; j++ {
            if (nums[i] & (1 << j)) != 0 {
                last[j] = i
            }
            if last[j] != -1 {
                maxLen = max(maxLen, last[j] - i + 1)
            }
        }
        res[i] = maxLen
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}