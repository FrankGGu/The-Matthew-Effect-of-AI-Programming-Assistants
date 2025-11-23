func minSwaps(data []int) int {
    onesCount := 0
    for _, num := range data {
        if num == 1 {
            onesCount++
        }
    }

    if onesCount == 0 {
        return 0
    }

    minSwaps := onesCount
    currentOnes := 0
    windowSize := onesCount

    for i := 0; i < len(data); i++ {
        if data[i] == 1 {
            currentOnes++
        }
        if i >= windowSize {
            if data[i-windowSize] == 1 {
                currentOnes--
            }
        }
        if i >= windowSize-1 {
            minSwaps = min(minSwaps, windowSize-currentOnes)
        }
    }

    return minSwaps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}