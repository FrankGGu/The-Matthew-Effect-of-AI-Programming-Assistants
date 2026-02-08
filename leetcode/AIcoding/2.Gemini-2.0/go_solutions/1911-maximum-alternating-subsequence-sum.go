func maxAlternatingSum(nums []int) int64 {
    even := int64(nums[0])
    odd := int64(0)
    for i := 1; i < len(nums); i++ {
        even, odd = max(even, odd+int64(nums[i])), max(odd, even-int64(nums[i]))
    }
    return even
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}