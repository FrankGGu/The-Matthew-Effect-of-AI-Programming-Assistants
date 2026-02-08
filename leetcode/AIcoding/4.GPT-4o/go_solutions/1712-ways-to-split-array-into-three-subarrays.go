func waysToSplit(nums []int) int {
    mod := 1_000_000_007
    n := len(nums)
    prefixSum := make([]int, n+1)
    for i := 1; i <= n; i++ {
        prefixSum[i] = prefixSum[i-1] + nums[i-1]
    }
    totalWays := 0
    j, k := 0, 0
    for i := 1; i < n; i++ {
        for j < i && prefixSum[j] < prefixSum[i]; j++ {
        }
        for k < n && prefixSum[k] - prefixSum[i] < prefixSum[n] - prefixSum[k] {
            k++
        }
        totalWays = (totalWays + k - j) % mod
    }
    return totalWays
}