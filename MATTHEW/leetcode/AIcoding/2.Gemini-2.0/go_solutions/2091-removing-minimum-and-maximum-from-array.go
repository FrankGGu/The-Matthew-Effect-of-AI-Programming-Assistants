func minimumDeletions(nums []int) int {
    n := len(nums)
    minIdx, maxIdx := 0, 0
    minVal, maxVal := nums[0], nums[0]
    for i := 1; i < n; i++ {
        if nums[i] < minVal {
            minVal = nums[i]
            minIdx = i
        }
        if nums[i] > maxVal {
            maxVal = nums[i]
            maxIdx = i
        }
    }

    a := min(minIdx, maxIdx)
    b := max(minIdx, maxIdx)

    return min(b+1, min(n-a, a+1+n-b))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}