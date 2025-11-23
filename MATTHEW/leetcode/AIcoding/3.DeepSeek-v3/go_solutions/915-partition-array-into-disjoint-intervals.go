func partitionDisjoint(nums []int) int {
    n := len(nums)
    maxLeft := make([]int, n)
    minRight := make([]int, n)

    maxLeft[0] = nums[0]
    for i := 1; i < n; i++ {
        maxLeft[i] = max(maxLeft[i-1], nums[i])
    }

    minRight[n-1] = nums[n-1]
    for i := n - 2; i >= 0; i-- {
        minRight[i] = min(minRight[i+1], nums[i])
    }

    for i := 1; i < n; i++ {
        if maxLeft[i-1] <= minRight[i] {
            return i
        }
    }
    return -1
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