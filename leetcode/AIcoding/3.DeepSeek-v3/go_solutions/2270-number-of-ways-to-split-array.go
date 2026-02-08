func waysToSplitArray(nums []int) int {
    n := len(nums)
    prefix := make([]int64, n)
    prefix[0] = int64(nums[0])
    for i := 1; i < n; i++ {
        prefix[i] = prefix[i-1] + int64(nums[i])
    }

    res := 0
    for i := 0; i < n-1; i++ {
        left := prefix[i]
        right := prefix[n-1] - prefix[i]
        if left >= right {
            res++
        }
    }
    return res
}