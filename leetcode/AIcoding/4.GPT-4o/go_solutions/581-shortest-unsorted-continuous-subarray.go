func findUnsortedSubarray(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    left, right := -1, -1
    min, max := nums[n-1], nums[0]

    for i := 1; i < n; i++ {
        max = maxInt(max, nums[i])
        if nums[i] < max {
            right = i
        }
    }

    for i := n - 2; i >= 0; i-- {
        min = minInt(min, nums[i])
        if nums[i] > min {
            left = i
        }
    }

    if left == -1 {
        return 0
    }

    return right - left + 1
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