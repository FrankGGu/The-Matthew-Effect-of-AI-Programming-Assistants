func removePalindromeSub(s string) int {
    isPalindrome := true
    n := len(s)
    for i := 0; i < n/2; i++ {
        if s[i] != s[n-i-1] {
            isPalindrome = false
            break
        }
    }
    if isPalindrome {
        return 1
    }
    return 2
}