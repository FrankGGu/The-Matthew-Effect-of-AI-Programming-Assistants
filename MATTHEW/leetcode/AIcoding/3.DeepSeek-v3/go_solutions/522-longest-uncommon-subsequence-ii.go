func findLUSlength(strs []string) int {
    maxLen := -1
    n := len(strs)

    for i := 0; i < n; i++ {
        current := strs[i]
        isCandidate := true

        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            if isSubsequence(current, strs[j]) {
                isCandidate = false
                break
            }
        }

        if isCandidate && len(current) > maxLen {
            maxLen = len(current)
        }
    }

    return maxLen
}

func isSubsequence(a, b string) bool {
    i, j := 0, 0
    for i < len(a) && j < len(b) {
        if a[i] == b[j] {
            i++
        }
        j++
    }
    return i == len(a)
}