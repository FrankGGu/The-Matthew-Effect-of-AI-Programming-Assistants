func getSumAbsoluteDifferences(nums []int) []int {
    n := len(nums)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + nums[i]
    }

    res := make([]int, n)
    for i := 0; i < n; i++ {
        leftSum := nums[i]*i - prefix[i]
        rightSum := (prefix[n] - prefix[i+1]) - nums[i]*(n-i-1)
        res[i] = leftSum + rightSum
    }
    return res
}