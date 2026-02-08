func maximumSubsequenceCount(text string, pattern string) int64 {
    count := 0
    total := 0
    prefixCount := 0
    suffixCount := 0

    for i := 0; i < len(text)-1; i++ {
        if text[i:i+1] == string(pattern[0]) {
            prefixCount++
        }
        if text[i:i+1] == string(pattern[1]) {
            suffixCount++
        }
    }

    if string(pattern[0]) == string(pattern[1]) {
        return int64(prefixCount + 1)
    }

    for i := 0; i < len(text); i++ {
        if text[i:i+1] == string(pattern[0]) {
            count += suffixCount
        }
        if text[i:i+1] == string(pattern[1]) {
            suffixCount--
        }
    }

    return int64(count + prefixCount)
}