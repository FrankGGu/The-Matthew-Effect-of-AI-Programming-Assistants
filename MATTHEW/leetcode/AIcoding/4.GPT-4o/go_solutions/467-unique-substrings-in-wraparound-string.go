func findSubstringInWraproundString(p string) int {
    maxLen := make([]int, 26)
    curLen := 0

    for i := 0; i < len(p); i++ {
        if i > 0 && (p[i]-p[i-1]+26)%26 == 1 {
            curLen++
        } else {
            curLen = 1
        }
        idx := p[i] - 'a'
        if curLen > maxLen[idx] {
            maxLen[idx] = curLen
        }
    }

    res := 0
    for _, length := range maxLen {
        res += length
    }
    return res
}