func shiftDistance(s string, t string) int {
    if len(s) != len(t) {
        return -1
    }

    n := len(s)
    diffCount := 0
    for i := 0; i < n; i++ {
        if s[i] != t[i] {
            diffCount++
        }
    }

    return diffCount
}