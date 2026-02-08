func getAverages(nums []int, k int) []int {
    n := len(nums)
    res := make([]int, n)
    for i := range res {
        res[i] = -1
    }
    if 2*k+1 > n {
        return res
    }
    prefix := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + int64(nums[i])
    }
    for i := k; i < n-k; i++ {
        sum := prefix[i+k+1] - prefix[i-k]
        res[i] = int(sum / int64(2*k+1))
    }
    return res
}