func canPartition(nums []int) bool {
    product := 1
    for _, num := range nums {
        product *= num
    }
    if product%2 != 0 {
        return false
    }
    target := product / 2

    dp := make([]bool, target+1)
    dp[0] = true

    for _, num := range nums {
        for j := target; j >= num; j-- {
            dp[j] = dp[j] || dp[j-num]
        }
    }
    return dp[target]
}