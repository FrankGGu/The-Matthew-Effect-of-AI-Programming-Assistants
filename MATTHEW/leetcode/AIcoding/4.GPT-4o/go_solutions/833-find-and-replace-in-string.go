func findReplaceString(s string, indices []int, sources []string, targets []string) string {
    result := []rune(s)
    m := make(map[int]int)

    for i := range indices {
        m[indices[i]] = i
    }

    for i := 0; i < len(s); i++ {
        if idx, ok := m[i]; ok {
            src := sources[idx]
            if strings.HasPrefix(s[i:], src) {
                copy(result[i+len(src):], result[i+len(src):])
                copy(result[i:], []rune(targets[idx]))
                i += len(targets[idx]) - 1
            }
        }
    }

    return string(result)
}