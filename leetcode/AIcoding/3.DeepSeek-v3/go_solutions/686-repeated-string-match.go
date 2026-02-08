func repeatedStringMatch(a string, b string) int {
    maxRepeat := len(b)/len(a) + 2
    var sb strings.Builder
    for i := 0; i < maxRepeat; i++ {
        sb.WriteString(a)
        if strings.Contains(sb.String(), b) {
            return i + 1
        }
    }
    return -1
}