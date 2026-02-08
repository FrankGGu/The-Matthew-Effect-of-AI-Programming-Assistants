func countPrefixSuffixPairs(words []string) int64 {
    count := int64(0)
    n := len(words)
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if isPrefixAndSuffix(words[i], words[j]) {
                count++
            }
        }
    }
    return count
}

func isPrefixAndSuffix(s1, s2 string) bool {
    if len(s1) > len(s2) {
        return false
    }
    return strings.HasPrefix(s2, s1) && strings.HasSuffix(s2, s1)
}