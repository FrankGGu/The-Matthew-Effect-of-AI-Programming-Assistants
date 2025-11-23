package main

func isPalindrome(s string) bool {
    left := 0
    right := len(s) - 1

    for left < right {
        for left < right && !isAlphanumeric(s[left]) {
            left++
        }
        for left < right && !isAlphanumeric(s[right]) {
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

func isAlphanumeric(b byte) bool {
    return (b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || (b >= '0' && b <= '9')
}