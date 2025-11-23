func shortestPalindrome(s string) string {
    n := len(s)
    if n == 0 {
        return ""
    }
    rev := reverse(s)
    for i := 0; i < n; i++ {
        if s[:n-i] == rev[i:] {
            return rev[:i] + s
        }
    }
    return rev + s
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}