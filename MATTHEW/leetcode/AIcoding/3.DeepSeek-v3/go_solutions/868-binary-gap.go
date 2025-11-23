func binaryGap(n int) int {
    maxGap := 0
    lastPos := -1
    pos := 0

    for n > 0 {
        if n & 1 == 1 {
            if lastPos != -1 && pos - lastPos > maxGap {
                maxGap = pos - lastPos
            }
            lastPos = pos
        }
        n >>= 1
        pos++
    }

    return maxGap
}