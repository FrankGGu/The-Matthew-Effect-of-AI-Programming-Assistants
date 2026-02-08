func minimumDifference(nums []int) int {
    total := 0
    n := len(nums)
    half := n / 2
    for _, num := range nums {
        total += num
    }

    dp := make([]bool, total/2+1)
    dp[0] = true

    for i := 0; i < half; i++ {
        for j := total/2; j >= nums[i]; j-- {
            dp[j] = dp[j] || dp[j-nums[i]]
        }
    }

    for i := half; i < n; i++ {
        for j := total/2; j >= nums[i]; j-- {
            dp[j] = dp[j] || dp[j-nums[i]]
        }
    }

    for j := total / 2; j >= 0; j-- {
        if dp[j] {
            return total - 2*j
        }
    }
    return total
}