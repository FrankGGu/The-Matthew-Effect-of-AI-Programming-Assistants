func checkPalindromeFormation(a string, b string) bool {
    return check(a, b) || check(b, a)
}

func check(a string, b string) bool {
    left, right := 0, len(a)-1
    for left < right && a[left] == b[right] {
        left++
        right--
    }
    return isPalindrome(a, left, right) || isPalindrome(b, left, right)
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