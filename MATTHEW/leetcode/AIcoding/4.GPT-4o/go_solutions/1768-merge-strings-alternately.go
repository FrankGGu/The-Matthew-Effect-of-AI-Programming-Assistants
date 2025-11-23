func mergeAlternately(word1 string, word2 string) string {
    var result strings.Builder
    n, m := len(word1), len(word2)
    minLen := n
    if m < n {
        minLen = m
    }

    for i := 0; i < minLen; i++ {
        result.WriteByte(word1[i])
        result.WriteByte(word2[i])
    }

    if n > minLen {
        result.WriteString(word1[minLen:])
    }
    if m > minLen {
        result.WriteString(word2[minLen:])
    }

    return result.String()
}