func checkPalindromeFormation(a string, b string) bool {
    isPalindrome := func(s string) bool {
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

    return isPalindrome(a) || isPalindrome(b) || isPalindrome(a[:len(a)-1]+b) || isPalindrome(b[:len(b)-1]+a)
}