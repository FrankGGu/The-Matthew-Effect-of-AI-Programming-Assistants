func binaryGap(n int) int {
    maxGap := 0
    lastOneIndex := -1
    currentBitIndex := 0

    for n > 0 {
        if n&1 == 1 { // Current bit is 1
            if lastOneIndex != -1 { // Found a previous 1
                currentGap := currentBitIndex - lastOneIndex
                if currentGap > maxGap {
                    maxGap = currentGap
                }
            }
            lastOneIndex = currentBitIndex
        }
        n >>= 1
        currentBitIndex++
    }

    return maxGap
}