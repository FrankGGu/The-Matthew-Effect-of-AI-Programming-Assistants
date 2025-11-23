func countPrefixSuffixPairs(words []string) int {
    count := 0
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

func isPrefixAndSuffix(s, t string) bool {
    if len(s) > len(t) {
        return false
    }
    return strings.HasPrefix(t, s) && strings.HasSuffix(t, s)
}