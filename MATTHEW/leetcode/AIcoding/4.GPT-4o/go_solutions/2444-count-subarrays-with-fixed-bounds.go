func countSubarrays(nums []int, minK int, maxK int) int {
    count := 0
    leftBound := -1
    minPos := -1
    maxPos := -1

    for i, num := range nums {
        if num < minK || num > maxK {
            leftBound = i
        }
        if num == minK {
            minPos = i
        }
        if num == maxK {
            maxPos = i
        }
        count += max(0, min(minPos, maxPos) - leftBound)
    }
    return count
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