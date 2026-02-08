func longestCommonPrefix(strs []string) string {
    if len(strs) == 0 {
        return ""
    }
    prefix := strs[0]
    for i := 1; i < len(strs); i++ {
        for j := 0; j < len(prefix) && j < len(strs[i]) && prefix[j] == strs[i][j]; j++ {
            if j == len(prefix)-1 {
                prefix = prefix[:j]
            }
        }
        if len(prefix) == 0 {
            break
        }
    }
    return prefix
}