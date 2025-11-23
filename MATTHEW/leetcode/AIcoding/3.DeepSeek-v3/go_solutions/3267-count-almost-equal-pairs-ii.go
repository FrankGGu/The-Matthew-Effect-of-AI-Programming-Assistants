func countAlmostEqualPairs(words []string) int64 {
    count := int64(0)
    n := len(words)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if isAlmostEqual(words[i], words[j]) {
                count++
            }
        }
    }
    return count
}

func isAlmostEqual(a, b string) bool {
    if len(a) != len(b) {
        return false
    }
    diff := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            diff++
            if diff > 2 {
                return false
            }
        }
    }
    return diff <= 2
}