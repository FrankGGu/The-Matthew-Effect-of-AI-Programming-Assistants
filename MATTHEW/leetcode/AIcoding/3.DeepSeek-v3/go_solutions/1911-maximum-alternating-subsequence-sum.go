func maxAlternatingSum(nums []int) int64 {
    even, odd := int64(0), int64(math.MinInt64)
    for _, num := range nums {
        newEven := max(even, odd - int64(num))
        newOdd := max(odd, even + int64(num))
        even, odd = newEven, newOdd
    }
    return max(even, odd)
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}