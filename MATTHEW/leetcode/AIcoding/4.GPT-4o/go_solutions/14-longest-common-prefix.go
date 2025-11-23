func longestCommonPrefix(strs []string) string {
    if len(strs) == 0 {
        return ""
    }
    prefix := strs[0]
    for _, str := range strs[1:] {
        for len(prefix) > 0 && !strings.HasPrefix(str, prefix) {
            prefix = prefix[:len(prefix)-1]
        }
    }
    return prefix
}