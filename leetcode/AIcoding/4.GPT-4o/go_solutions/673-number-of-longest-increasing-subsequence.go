func findNumberOfLIS(nums []int) int {
    if len(nums) == 0 {
        return 0
    }

    n := len(nums)
    lengths := make([]int, n)
    counts := make([]int, n)

    for i := 0; i < n; i++ {
        lengths[i] = 1
        counts[i] = 1
    }

    maxLength := 1
    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            if nums[i] > nums[j] {
                if lengths[j] + 1 > lengths[i] {
                    lengths[i] = lengths[j] + 1
                    counts[i] = counts[j]
                } else if lengths[j] + 1 == lengths[i] {
                    counts[i] += counts[j]
                }
            }
        }
        maxLength = max(maxLength, lengths[i])
    }

    totalCount := 0
    for i := 0; i < n; i++ {
        if lengths[i] == maxLength {
            totalCount += counts[i]
        }
    }

    return totalCount
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}