func binaryGap(n int) int {
    lastPos := -1
    maxGap := 0

    for i := 0; n > 0; i++ {
        if n&1 == 1 {
            if lastPos != -1 {
                maxGap = max(maxGap, i-lastPos)
            }
            lastPos = i
        }
        n >>= 1
    }

    return maxGap
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}