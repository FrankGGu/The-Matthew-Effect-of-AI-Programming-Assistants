func printVertically(s string) []string {
    words := strings.Split(s, " ")
    maxLen := 0
    for _, word := range words {
        if len(word) > maxLen {
            maxLen = len(word)
        }
    }

    res := make([]string, maxLen)
    for i := 0; i < maxLen; i++ {
        var sb strings.Builder
        for _, word := range words {
            if i < len(word) {
                sb.WriteByte(word[i])
            } else {
                sb.WriteByte(' ')
            }
        }
        res[i] = strings.TrimRight(sb.String(), " ")
    }
    return res
}