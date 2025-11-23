func constrainedSubsetSum(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    dp[0] = nums[0]
    q := []int{0}
    res := dp[0]

    for i := 1; i < n; i++ {
        for len(q) > 0 && q[0] < i - k {
            q = q[1:]
        }
        if len(q) > 0 {
            dp[i] = max(nums[i], dp[q[0]] + nums[i])
        } else {
            dp[i] = nums[i]
        }
        res = max(res, dp[i])
        for len(q) > 0 && dp[i] >= dp[q[len(q)-1]] {
            q = q[:len(q)-1]
        }
        q = append(q, i)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}