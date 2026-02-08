func checkPalindromeFormation(a string, b string) bool {
    isPalindrome := func(s string, left int, right int) bool {
        for left < right {
            if s[left] != s[right] {
                return false
            }
            left++
            right--
        }
        return true
    }

    n := len(a)
    return isPalindrome(a, 0, n-1) || isPalindrome(b, 0, n-1) || 
           isPalindrome(a, 0, n/2-1) && isPalindrome(b, n/2, n-1) || 
           isPalindrome(b, 0, n/2-1) && isPalindrome(a, n/2, n-1)
}