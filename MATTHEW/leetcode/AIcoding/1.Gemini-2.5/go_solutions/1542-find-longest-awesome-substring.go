func longestAwesome(s string) int {
    n := len(s)

    maskToIndex := make([]int, 1<<10)
    for i := range maskToIndex {
        maskToIndex[i] = -1
    }
    maskToIndex[0] = 0

    maxLen := 0
    currentMask := 0

    for i := 0; i < n; i++ {
        digit := int(s[i] - '0')
        currentMask ^= (1 << digit)

        if maskToIndex[currentMask] != -1 {
            maxLen = max(maxLen, i+1-maskToIndex[currentMask])
        }

        for k := 0; k < 10; k++ {
            targetMask := currentMask ^ (1 << k)
            if maskToIndex[targetMask] != -1 {
                maxLen = max(maxLen, i+1-maskToIndex[targetMask])
            }
        }

        if maskToIndex[currentMask] == -1 {
            maskToIndex[currentMask] = i + 1
        }
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}