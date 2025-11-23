func longestSemiRepetitiveSubstring(s string) int {
    n := len(s)
    if n <= 2 {
        return n
    }

    maxLen := 0
    left := 0
    consecutivePairs := 0 // Counts pairs s[i] == s[i+1]

    for right :=