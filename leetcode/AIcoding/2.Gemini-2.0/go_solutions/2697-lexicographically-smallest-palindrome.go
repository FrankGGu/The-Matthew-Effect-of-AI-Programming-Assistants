func makeSmallestPalindrome(s string) string {
    n := len(s)
    runes := []rune(s)
    for i := 0; i < n/2; i++ {
        if runes[i] != runes[n-1-i] {
            if runes[i] < runes[n-1-i] {
                runes[n-1-i] = runes[i]
            } else {
                runes[i] = runes[n-1-i]
            }
        }
    }
    return string(runes)
}