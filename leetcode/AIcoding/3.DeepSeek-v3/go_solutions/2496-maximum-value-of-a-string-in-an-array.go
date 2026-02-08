func maximumValue(strs []string) int {
    maxVal := 0
    for _, s := range strs {
        val := 0
        hasLetter := false
        for _, c := range s {
            if c >= '0' && c <= '9' {
                val = val * 10 + int(c - '0')
            } else {
                hasLetter = true
                break
            }
        }
        if hasLetter {
            val = len(s)
        }
        if val > maxVal {
            maxVal = val
        }
    }
    return maxVal
}