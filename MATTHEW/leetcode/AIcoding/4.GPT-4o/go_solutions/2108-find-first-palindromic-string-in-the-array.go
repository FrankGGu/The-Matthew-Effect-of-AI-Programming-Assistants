func isPalindrome(s string) bool {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}

func firstPalindromic(strings []string) string {
    for _, s := range strings {
        if isPalindrome(s) {
            return s
        }
    }
    return ""
}