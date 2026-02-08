func makeSmallestPalindrome(s string) string {
    n := len(s)
    res := make([]byte, n)
    for i := 0; i < n/2; i++ {
        if s[i] < s[n-1-i] {
            res[i] = s[i]
            res[n-1-i] = s[i]
        } else {
            res[i] = s[n-1-i]
            res[n-1-i] = s[n-1-i]
        }
    }
    if n%2 == 1 {
        res[n/2] = s[n/2]
    }
    return string(res)
}