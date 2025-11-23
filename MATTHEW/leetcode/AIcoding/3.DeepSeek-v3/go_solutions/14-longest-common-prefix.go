func longestCommonPrefix(strs []string) string {
    if len(strs) == 0 {
        return ""
    }
    prefix := strs[0]
    for i := 1; i < len(strs); i++ {
        for j := 0; j < len(prefix); j++ {
            if j >= len(strs[i]) || strs[i][j] != prefix[j] {
                prefix = prefix[:j]
                break
            }
        }
        if prefix == "" {
            break
        }
    }
    return prefix
}