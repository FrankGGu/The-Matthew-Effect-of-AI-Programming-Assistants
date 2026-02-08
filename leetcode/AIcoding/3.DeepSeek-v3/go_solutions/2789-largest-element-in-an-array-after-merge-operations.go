func maxArrayValue(nums []int) int64 {
    n := len(nums)
    if n == 0 {
        return 0
    }
    maxVal := int64(nums[n-1])
    current := maxVal
    for i := n - 2; i >= 0; i-- {
        num := int64(nums[i])
        if num <= current {
            current += num
        } else {
            current = num
        }
        if current > maxVal {
            maxVal = current
        }
    }
    return maxVal
}