func countQuadruplets(nums []int) int64 {
    n := len(nums)
    var res int64
    dp := make([]int, n)

    for j := 0; j < n; j++ {
        var smaller int
        for i := 0; i < j; i++ {
            if nums[i] < nums[j] {
                smaller++
                res += int64(dp[i])
            } else if nums[i] > nums[j] {
                dp[i] += smaller
            }
        }
    }
    return res
}