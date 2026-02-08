func countKeyChanges(s string) int {
    count := 0
    lowerS := strings.ToLower(s)
    for i := 1; i < len(lowerS); i++ {
        if lowerS[i] != lowerS[i-1] {
            count++
        }
    }
    return count
}