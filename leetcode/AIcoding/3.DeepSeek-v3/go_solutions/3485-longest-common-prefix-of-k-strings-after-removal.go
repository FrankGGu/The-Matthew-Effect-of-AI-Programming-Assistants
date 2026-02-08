func longestCommonPrefix(strs []string) string {
    if len(strs) == 0 {
        return ""
    }
    prefix := strs[0]
    for i := 1; i < len(strs); i++ {
        for !strings.HasPrefix(strs[i], prefix) {
            prefix = prefix[:len(prefix)-1]
            if prefix == "" {
                return ""
            }
        }
    }
    return prefix
}

func longestCommonPrefixAfterRemoval(strs []string, k int) string {
    maxPrefix := ""
    n := len(strs)
    if n == 0 {
        return ""
    }

    for i := 0; i < n; i++ {
        currentStrs := make([]string, 0, n-1)
        for j := 0; j < n; j++ {
            if j != i {
                currentStrs = append(currentStrs, strs[j])
            }
        }
        currentPrefix := longestCommonPrefix(currentStrs)
        if len(currentPrefix) > len(maxPrefix) {
            maxPrefix = currentPrefix
        }
    }

    if k == 1 {
        return maxPrefix
    }

    for i := 0; i < n; i++ {
        newStrs := make([]string, 0, n-1)
        for j := 0; j < n; j++ {
            if j != i {
                newStrs = append(newStrs, strs[j])
            }
        }
        currentPrefix := longestCommonPrefixAfterRemoval(newStrs, k-1)
        if len(currentPrefix) > len(maxPrefix) {
            maxPrefix = currentPrefix
        }
    }

    return maxPrefix
}