func minSubArrayLen(target int, nums []int) int {
    n := len(nums)
    ans := n + 1
    left := 0
    sum := 0
    for right := 0; right < n; right++ {
        sum += nums[right]
        for sum >= target {
            ans = min(ans, right-left+1)
            sum -= nums[left]
            left++
        }
    }
    if ans == n+1 {
        return 0
    }
    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}