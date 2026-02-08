func minSubArrayLen(target int, nums []int) int {
    n := len(nums)
    left, sum, minLen := 0, 0, n+1

    for right := 0; right < n; right++ {
        sum += nums[right]
        for sum >= target {
            minLen = min(minLen, right-left+1)
            sum -= nums[left]
            left++
        }
    }

    if minLen == n+1 {
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