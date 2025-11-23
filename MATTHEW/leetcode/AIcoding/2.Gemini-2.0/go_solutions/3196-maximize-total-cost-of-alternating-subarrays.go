func maxAlternatingSum(nums []int) int64 {
    n := len(nums)
    even := int64(nums[0])
    odd := int64(0)
    for i := 1; i < n; i++ {
        newEven := max(even, odd+int64(nums[i]))
        newOdd := max(odd, even-int64(nums[i]))
        even = newEven
        odd = newOdd
    }
    return even
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}