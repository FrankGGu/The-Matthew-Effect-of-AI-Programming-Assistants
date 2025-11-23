func findUnsortedSubarray(nums []int) int {
    n := len(nums)
    start, end := -1, -2
    min, max := nums[n-1], nums[0]

    for i := 1; i < n; i++ {
        max = maxInt(max, nums[i])
        if nums[i] < max {
            end = i
        }
    }

    for i := n - 2; i >= 0; i-- {
        min = minInt(min, nums[i])
        if nums[i] > min {
            start = i
        }
    }

    return end - start + 1
}

func maxInt(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func minInt(a, b int) int {
    if a < b {
        return a
    }
    return b
}