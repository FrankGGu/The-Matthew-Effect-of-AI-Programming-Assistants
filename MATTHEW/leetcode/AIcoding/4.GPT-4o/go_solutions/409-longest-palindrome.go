func longestPalindrome(s string) string {
    n := len(s)
    if n < 2 {
        return s
    }
    start, maxLen := 0, 1

    for i := 0; i < n; i++ {
        // Check for odd length palindromes
        left, right := i, i
        for left >= 0 && right < n && s[left] == s[right] {
            if right-left+1 > maxLen {
                start = left
                maxLen = right - left + 1
            }
            left--
            right++
        }
        // Check for even length palindromes
        left, right = i, i+1
        for left >= 0 && right < n && s[left] == s[right] {
            if right-left+1 > maxLen {
                start = left
                maxLen = right - left + 1
            }
            left--
            right++
        }
    }
    return s[start : start+maxLen]
}