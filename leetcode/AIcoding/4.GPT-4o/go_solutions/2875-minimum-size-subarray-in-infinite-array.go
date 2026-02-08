func minSubArrayLen(target int, nums []int) int {
    n := len(nums)
    left, sum, minLength := 0, 0, n+1

    for right := 0; right < n; right++ {
        sum += nums[right]
        for sum >= target {
            minLength = min(minLength, right-left+1)
            sum -= nums[left]
            left++
        }
    }

    if minLength == n+1 {
        return 0
    }
    return minLength
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}