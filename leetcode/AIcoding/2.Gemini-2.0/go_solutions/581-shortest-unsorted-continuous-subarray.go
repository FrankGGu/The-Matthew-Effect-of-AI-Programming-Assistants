func findUnsortedSubarray(nums []int) int {
    n := len(nums)
    l, r := -1, -2
    maxVal := nums[0]
    minVal := nums[n-1]

    for i := 1; i < n; i++ {
        maxVal = max(maxVal, nums[i])
        minVal = min(minVal, nums[n-1-i])

        if nums[i] < maxVal {
            r = i
        }
        if nums[n-1-i] > minVal {
            l = n-1-i
        }
    }

    return r - l + 1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}