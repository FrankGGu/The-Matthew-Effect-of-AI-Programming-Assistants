func maxChunksToSorted(arr []int) int {
    maxVal := 0
    chunks := 0
    for i, num := range arr {
        if num > maxVal {
            maxVal = num
        }
        if maxVal == i {
            chunks++
        }
    }
    return chunks
}