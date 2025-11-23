func countSubarrays(nums []int, minK int, maxK int) int64 {
    res := int64(0)
    minPos, maxPos, left := -1, -1, -1
    for i := 0; i < len(nums); i++ {
        if nums[i] < minK || nums[i] > maxK {
            left = i
        }
        if nums[i] == minK {
            minPos = i
        }
        if nums[i] == maxK {
            maxPos = i
        }
        res += int64(max(0, min(minPos, maxPos) - left))
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}