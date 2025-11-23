func oddString(words []string) string {
    diffMap := make(map[string][]string)
    for _, word := range words {
        diff := make([]byte, len(word)-1)
        for i := 0; i < len(word)-1; i++ {
            diff[i] = word[i+1] - word[i]
        }
        key := string(diff)
        diffMap[key] = append(diffMap[key], word)
    }
    for _, v := range diffMap {
        if len(v) == 1 {
            return v[0]
        }
    }
    return ""
}