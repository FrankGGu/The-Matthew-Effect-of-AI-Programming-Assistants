func getSumAbsoluteDifferences(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    prefixSum := make([]int, n+1)

    for i := 1; i <= n; i++ {
        prefixSum[i] = prefixSum[i-1] + nums[i-1]
    }

    for i := 0; i < n; i++ {
        leftSum := i * nums[i] - prefixSum[i]
        rightSum := prefixSum[n] - prefixSum[i+1] - (n-i-1)*nums[i]
        result[i] = leftSum + rightSum
    }

    return result
}