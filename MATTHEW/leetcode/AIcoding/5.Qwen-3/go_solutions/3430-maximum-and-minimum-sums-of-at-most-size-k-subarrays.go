package main

func maxSumOfSubarrays(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, n)
    maxSum := 0
    currentSum := 0
    for i := 0; i < k; i++ {
        currentSum += arr[i]
    }
    dp[k-1] = currentSum
    maxSum = currentSum
    for i := k; i < n; i++ {
        currentSum += arr[i] - arr[i-k]
        dp[i] = max(dp[i-1], currentSum)
        if dp[i] > maxSum {
            maxSum = dp[i]
        }
    }
    return maxSum
}

func minSumOfSubarrays(arr []int, k int) int {
    n := len(arr)
    dp := make([]int, n)
    minSum := 0
    currentSum := 0
    for i := 0; i < k; i++ {
        currentSum += arr[i]
    }
    dp[k-1] = currentSum
    minSum = currentSum
    for i := k; i < n; i++ {
        currentSum += arr[i] - arr[i-k]
        dp[i] = min(dp[i-1], currentSum)
        if dp[i] < minSum {
            minSum = dp[i]
        }
    }
    return minSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}