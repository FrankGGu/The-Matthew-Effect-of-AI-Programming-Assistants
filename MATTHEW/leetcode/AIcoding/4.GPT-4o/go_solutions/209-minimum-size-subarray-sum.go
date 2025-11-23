func minSubArrayLen(target int, nums []int) int {
    left, sum, minLen := 0, 0, len(nums)+1
    for right := 0; right < len(nums); right++ {
        sum += nums[right]
        for sum >= target {
            minLen = min(minLen, right-left+1)
            sum -= nums[left]
            left++
        }
    }
    if minLen == len(nums)+1 {
        return 0
    }
    return minLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}