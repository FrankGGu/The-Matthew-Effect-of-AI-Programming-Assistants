func checkPalindromeFormation(a string, b string) bool {
    isPalindrome := func(s string, left, right int) bool {
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
    for i := 0; i < n/2; i++ {
        if a[i] != b[n-1-i] {
            return isPalindrome(a, i, n-1-i) || isPalindrome(b, i, n-1-i)
        }
    }
    return true
}