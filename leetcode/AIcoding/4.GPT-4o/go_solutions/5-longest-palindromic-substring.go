func longestPalindrome(s string) string {
    n := len(s)
    if n < 2 {
        return s
    }
    start, maxLen := 0, 1

    for i := 0; i < n; i++ {
        // Odd length palindrome
        l, r := i, i
        for l >= 0 && r < n && s[l] == s[r] {
            if r-l+1 > maxLen {
                start = l
                maxLen = r - l + 1
            }
            l--
            r++
        }

        // Even length palindrome
        l, r = i, i+1
        for l >= 0 && r < n && s[l] == s[r] {
            if r-l+1 > maxLen {
                start = l
                maxLen = r - l + 1
            }
            l--
            r++
        }
    }
    return s[start : start+maxLen]
}