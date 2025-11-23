func maxResult(nums []int, k int) int {
    n := len(nums)
    dp := make([]int, n)
    dp[0] = nums[0]
    queue := []int{0}

    for i := 1; i < n; i++ {
        for queue[0] < i-k {
            queue = queue[1:]
        }
        dp[i] = dp[queue[0]] + nums[i]
        for len(queue) > 0 && dp[queue[len(queue)-1]] <= dp[i] {
            queue = queue[:len(queue)-1]
        }
        queue = append(queue, i)
    }

    return dp[n-1]
}