func validPalindrome(s string) bool {
    left := 0
    right := len(s) - 1

    for left < right {
        if s[left] != s[right] {
            // Found a mismatch. Try deleting s[left] or s[right].
            // Check if s[left+