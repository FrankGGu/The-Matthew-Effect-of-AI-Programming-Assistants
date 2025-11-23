func breakPalindrome(palindrome string) string {
    n := len(palindrome)
    if n == 1 {
        return ""
    }
    p := []byte(palindrome)
    for i := 0; i < n/2; i++ {
        if p[i] != 'a' {
            p[i] = 'a'
            return string(p)
        }
    }
    p[n-1] = 'b'
    return string(p)
}