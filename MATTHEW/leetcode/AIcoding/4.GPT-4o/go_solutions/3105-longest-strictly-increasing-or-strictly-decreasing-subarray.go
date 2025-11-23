func longestSubarray(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    maxLen := 1
    currentLen := 1
    increasing := false
    decreasing := false

    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            if decreasing {
                maxLen = max(maxLen, currentLen)
                currentLen = 2
                decreasing = false
            } else {
                currentLen++
            }
            increasing = true
        } else if nums[i] < nums[i-1] {
            if increasing {
                maxLen = max(maxLen, currentLen)
                currentLen = 2
                increasing = false
            } else {
                currentLen++
            }
            decreasing = true
        } else {
            maxLen = max(maxLen, currentLen)
            currentLen = 1
            increasing = false
            decreasing = false
        }
    }

    return max(maxLen, currentLen)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}