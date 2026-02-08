func longestPalindrome(s string) string {
    if len(s) == 0 {
        return ""
    }
    start, maxLength := 0, 1
    for i := 0; i < len(s); i++ {
        // Odd length palindromes
        l, r := i, i
        for l >= 0 && r < len(s) && s[l] == s[r] {
            if r-l+1 > maxLength {
                start = l
                maxLength = r - l + 1
            }
            l--
            r++
        }
        // Even length palindromes
        l, r = i, i+1
        for l >= 0 && r < len(s) && s[l] == s[r] {
            if r-l+1 > maxLength {
                start = l
                maxLength = r - l + 1
            }
            l--
            r++
        }
    }
    return s[start : start+maxLength]
}