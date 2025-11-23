package main

func maximumSubarraySum(nums []int) int {
    n := len(nums)
    maxSum := -1 << 63
    prefix := make([]int, n+1)
    suffix := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefix[i+1] = max(prefix[i]+nums[i], nums[i])
    }

    for i := n - 1; i >= 0; i-- {
        suffix[i] = max(suffix[i+1]+nums[i], nums[i])
    }

    for i := 0; i < n; i++ {
        current := prefix[i] + suffix[i+1]
        if current > maxSum {
            maxSum = current
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}