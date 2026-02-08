func maxScore(nums []int, k int) int {
    n := len(nums)
    total := 0
    for _, num := range nums {
        total += num
    }

    if k >= n {
        return total
    }

    minSum := 0
    for i := 0; i < n-k; i++ {
        minSum += nums[i]
    }

    maxScore := total - minSum
    for i := n - k; i < n; i++ {
        minSum -= nums[i-n+k]
        minSum += nums[i]
        maxScore = max(maxScore, total-minSum)
    }

    return maxScore
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}