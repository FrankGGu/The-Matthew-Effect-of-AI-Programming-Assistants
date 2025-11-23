package main

func constrainedSubsequenceSum(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    dq := []int{}
    for i := 0; i < n; i++ {
        if len(dq) > 0 && dq[0] < i-k {
            dq = dq[1:]
        }
        if len(dq) > 0 {
            dp[i] = dp[dq[0]] + nums[i]
        } else {
            dp[i] = nums[i]
        }
        for len(dq) > 0 && dp[i] >= dp[dq[len(dq)-1]] {
            dq = dq[:len(dq)-1]
        }
        dq = append(dq, i)
    }
    max := dp[0]
    for _, v := range dp {
        if v > max {
            max = v
        }
    }
    return max
}