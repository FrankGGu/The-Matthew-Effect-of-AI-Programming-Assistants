func longestPrefix(s string) string {
    n := len(s)
    lps := make([]int, n)
    j := 0

    for i := 1; i < n; i++ {
        for j > 0 && s[i] != s[j] {
            j = lps[j-1]
        }
        if s[i] == s[j] {
            j++
            lps[i] = j
        } else {
            lps[i] = 0
        }
    }

    return s[:lps[n-1]]
}