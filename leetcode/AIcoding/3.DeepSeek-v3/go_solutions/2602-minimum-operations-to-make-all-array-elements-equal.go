func minOperations(nums []int, queries []int) []int64 {
    sort.Ints(nums)
    n := len(nums)
    prefix := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + int64(nums[i])
    }

    res := make([]int64, len(queries))
    for i, q := range queries {
        idx := sort.SearchInts(nums, q)
        left := int64(q)*int64(idx) - prefix[idx]
        right := (prefix[n] - prefix[idx]) - int64(q)*int64(n - idx)
        res[i] = left + right
    }
    return res
}