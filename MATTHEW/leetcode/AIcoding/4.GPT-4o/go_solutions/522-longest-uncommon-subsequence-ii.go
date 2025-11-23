func findLUSlength(strs []string) int {
    var maxLen int
    for i := 0; i < len(strs); i++ {
        isSubsequence := false
        for j := 0; j < len(strs); j++ {
            if i != j && isSubsequenceOf(strs[i], strs[j]) {
                isSubsequence = true
                break
            }
        }
        if !isSubsequence {
            maxLen = max(maxLen, len(strs[i]))
        }
    }
    if maxLen == 0 {
        return -1
    }
    return maxLen
}

func isSubsequenceOf(s1, s2 string) bool {
    i, j := 0, 0
    for i < len(s1) && j < len(s2) {
        if s1[i] == s2[j] {
            i++
        }
        j++
    }
    return i == len(s1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}