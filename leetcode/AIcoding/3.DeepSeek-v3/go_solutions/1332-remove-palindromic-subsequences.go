func removePalindromeSub(s string) int {
    if len(s) == 0 {
        return 0
    }
    if isPalindrome(s) {
        return 1
    }
    return 2
}

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