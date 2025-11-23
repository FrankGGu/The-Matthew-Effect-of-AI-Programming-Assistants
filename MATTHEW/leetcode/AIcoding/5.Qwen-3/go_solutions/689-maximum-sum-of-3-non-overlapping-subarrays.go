package main

func maxSumOfThreeSubarrays(nums []int, k int) []int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)
    dp := make([]int, n)

    for i := 0; i < n; i++ {
        if i == 0 {
            dp[i] = nums[i]
        } else {
            dp[i] = dp[i-1] + nums[i]
        }
    }

    for i := 0; i < n; i++ {
        if i == 0 {
            left[i] = 0
        } else {
            left[i] = left[i-1]
            if i-k >= 0 && dp[i] - dp[i-k] > dp[left[i]] - dp[left[i]-k] {
                left[i] = i - k + 1
            }
        }
    }

    for i := n - 1; i >= 0; i-- {
        if i == n-1 {
            right[i] = n - 1
        } else {
            right[i] = right[i+1]
            if i+k < n && dp[i+k] - dp[i] > dp[right[i]] - dp[right[i]-k] {
                right[i] = i + 1
            }
        }
    }

    res := []int{-1, -1, -1}
    maxSum := 0

    for i := k; i <= n - k; i++ {
        l := left[i-1]
        r := right[i+k]
        currentSum := (dp[i] - dp[i-k]) + (dp[l+k] - dp[l]) + (dp[r+k] - dp[r])
        if currentSum > maxSum {
            maxSum = currentSum
            res = []int{l, i - k + 1, r}
        }
    }

    return res
}