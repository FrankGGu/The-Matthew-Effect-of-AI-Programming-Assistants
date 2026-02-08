func findFirstAlmostEqualSubstring(s string, t string) int {
    n := len(s)
    m := len(t)
    for i := 0; i <= n-m; i++ {
        if isAlmostEqual(s[i:i+m], t) {
            return i
        }
    }
    return -1
}

func isAlmostEqual(substr string, t string) bool {
    diffCount := 0
    for i := 0; i < len(substr); i++ {
        if substr[i] != t[i] {
            diffCount++
        }
        if diffCount > 1 {
            return false
        }
    }
    return diffCount == 1
}