func getXSum(nums []int, k int) int {
    n := len(nums)
    if n == 0 || k <= 0 || k > n {
        return 0
    }

    sum := 0
    for i := 0; i < k; i++ {
        sum += nums[i]
    }

    xSum := sum
    for i := k; i < n; i++ {
        sum += nums[i] - nums[i-k]
        xSum ^= sum
    }

    return xSum
}