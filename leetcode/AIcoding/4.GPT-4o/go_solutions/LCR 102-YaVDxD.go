func findTargetSumWays(nums []int, target int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if target > sum || (sum+target)%2 != 0 {
        return 0
    }
    s := (sum + target) / 2
    dp := make([]int, s+1)
    dp[0] = 1
    for _, num := range nums {
        for j := s; j >= num; j-- {
            dp[j] += dp[j-num]
        }
    }
    return dp[s]
}