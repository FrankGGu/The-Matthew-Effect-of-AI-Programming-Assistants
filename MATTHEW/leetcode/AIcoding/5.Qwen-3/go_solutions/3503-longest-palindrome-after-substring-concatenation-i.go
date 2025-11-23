package main

func longestPalindrome(s string) string {
    if len(s) < 2 {
        return s
    }

    var maxLen int
    var start int

    for i := 0; i < len(s); i++ {
        for j := i + 1; j < len(s); j++ {
            if s[i] == s[j] {
                if j-i+1 > maxLen && isPalindrome(s, i, j) {
                    maxLen = j - i + 1
                    start = i
                }
            }
        }
    }

    return s[start : start+maxLen]
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