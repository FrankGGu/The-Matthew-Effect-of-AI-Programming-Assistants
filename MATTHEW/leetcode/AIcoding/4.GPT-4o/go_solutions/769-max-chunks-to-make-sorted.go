func maxChunksToSorted(arr []int) int {
    maxVal := 0
    chunks := 0
    for i, val := range arr {
        maxVal = max(maxVal, val)
        if maxVal == i {
            chunks++
        }
    }
    return chunks
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}