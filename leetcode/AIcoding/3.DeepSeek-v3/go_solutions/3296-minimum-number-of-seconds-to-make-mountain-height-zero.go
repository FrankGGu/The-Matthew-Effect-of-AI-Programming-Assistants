func minimumTime(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    left := make([]int, n)
    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            left[i] = left[i-1] + (nums[i] - nums[i-1])
        } else {
            left[i] = left[i-1]
        }
    }

    right := make([]int, n)
    for i := n-2; i >= 0; i-- {
        if nums[i] > nums[i+1] {
            right[i] = right[i+1] + (nums[i] - nums[i+1])
        } else {
            right[i] = right[i+1]
        }
    }

    res := math.MaxInt32
    for i := 0; i < n; i++ {
        res = min(res, left[i] + right[i])
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}