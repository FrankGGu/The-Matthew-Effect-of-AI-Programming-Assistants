func longestNiceSubarray(nums []int) int {
    lastSeen := make(map[int]int)
    maxLen := 0
    left := 0

    for right, num := range nums {
        if lastIdx, found := lastSeen[num]; found && lastIdx >= left {
            left = lastIdx + 1
        }
        lastSeen[num] = right
        maxLen = max(maxLen, right-left+1)
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}