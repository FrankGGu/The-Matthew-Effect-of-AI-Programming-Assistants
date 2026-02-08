package main

func shortestPalindrome(s string) string {
    i := len(s) - 1
    for i >= 0 {
        if isPalindrome(s, 0, i) {
            break
        }
        i--
    }
    if i == len(s)-1 {
        return s
    }
    return reverse(s[i+1:]) + s
}

func isPalindrome(s string, left, right int) bool {
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}

func reverse(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}