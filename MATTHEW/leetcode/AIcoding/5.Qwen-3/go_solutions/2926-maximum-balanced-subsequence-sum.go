package main

func maxBalancedSubsequence(nums []int, k int) int {
    type pair struct {
        index int
        value int
    }
    n := len(nums)
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{i, nums[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].value < pairs[j].value || (pairs[i].value == pairs[j].value && pairs[i].index < pairs[j].index)
    })
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = nums[pairs[i].index]
    }
    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if abs(pairs[i].index-pairs[j].index) <= k {
                if dp[j]+nums[pairs[i].index] > dp[i] {
                    dp[i] = dp[j] + nums[pairs[i].index]
                }
            }
        }
    }
    maxSum := 0
    for i := 0; i < n; i++ {
        if dp[i] > maxSum {
            maxSum = dp[i]
        }
    }
    return maxSum
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}