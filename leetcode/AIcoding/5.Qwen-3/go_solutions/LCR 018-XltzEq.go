package main

func isPalindrome(s string) bool {
    left := 0
    right := len(s) - 1

    for left < right {
        for left < right && !isAlphaNum(s[left]) {
            left++
        }
        for left < right && !isAlphaNum(s[right]) {
            right--
        }
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}

func isAlphaNum(b byte) bool {
    return (b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || (b >= '0' && b <= '9')
}