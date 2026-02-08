func findSubstringInWraproundString(p string) int {
    count := [26]int{}
    maxLen := 0
    for i := 0; i < len(p); i++ {
        if i > 0 && (p[i] - p[i-1] == 1 || p[i-1] - p[i] == 25) {
            maxLen++
        } else {
            maxLen = 1
        }
        idx := p[i] - 'a'
        if maxLen > count[idx] {
            count[idx] = maxLen
        }
    }
    total := 0
    for _, v := range count {
        total += v
    }
    return total
}