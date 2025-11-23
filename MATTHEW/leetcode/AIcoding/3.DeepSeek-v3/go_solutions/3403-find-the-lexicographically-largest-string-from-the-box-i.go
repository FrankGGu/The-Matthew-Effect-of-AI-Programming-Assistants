func maxString(box []string) string {
    maxStr := ""
    for _, s := range box {
        if isSpecial(s) && (s > maxStr) {
            maxStr = s
        }
    }
    return maxStr
}

func isSpecial(s string) bool {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }
    for _, v := range count {
        if v > 1 {
            return true
        }
    }
    return false
}