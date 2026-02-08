func checkPalindromeFormation(a string, b string) bool {
    n := len(a)

    isPalindrome := func(s string, i, j int) bool {
        for i < j {
            if s[i] != s[j] {
                return false
            }
            i++
            j--
        }
        return true
    }

    check := func(s1, s2 string) bool {
        i, j := 0, n-1
        for i < j && s1[i] == s2[j] {
            i++
            j--
        }
        return isPalindrome(s1, i, j) || isPalindrome(s2, i, j)
    }

    return check(a, b) || check(b, a)
}