func minSubArrayLen(target int, nums []int) int {
    n := len(nums)
    minLen := n + 1
    left, sum := 0, 0

    for right := 0; right < n; right++ {
        sum += nums[right]
        for sum >= target {
            if right-left+1 < minLen {
                minLen = right - left + 1
            }
            sum -= nums[left]
            left++
        }
    }

    if minLen == n+1 {
        return 0
    }
    return minLen
}