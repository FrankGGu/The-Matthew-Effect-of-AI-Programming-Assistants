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

func checkPalindromeFormation(a string, b string) bool {
    return check(a, b) || check(b, a)
}

func check(a string, b string) bool {
    left, right := 0, len(a)-1
    for left < right && a[left] == b[right] {
        left++
        right--
    }
    return isPalindrome(a[left:right+1]) || isPalindrome(b[left:right+1])
}