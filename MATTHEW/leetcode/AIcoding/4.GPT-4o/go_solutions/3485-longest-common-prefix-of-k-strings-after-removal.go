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

func longestCommonPrefixAfterRemoval(strs []string, k int) string {
    n := len(strs)
    if n < k {
        return ""
    }

    var commonPrefix string
    for i := 0; i < n; i++ {
        temp := make([]string, 0, n-1)
        for j := 0; j < n; j++ {
            if i != j {
                temp = append(temp, strs[j])
            }
        }
        prefix := longestCommonPrefix(temp)
        if len(prefix) > len(commonPrefix) {
            commonPrefix = prefix
        }
    }

    return commonPrefix
}