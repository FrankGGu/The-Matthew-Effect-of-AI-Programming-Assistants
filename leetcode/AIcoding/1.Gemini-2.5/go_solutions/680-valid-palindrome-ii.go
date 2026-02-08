func validPalindrome(s string) bool {
    left, right := 0, len(s)-1

    for left < right {
        if s[left] == s[right] {
            left++
            right--
        } else {
            // Mismatch found. Try deleting s[left] or s[right].
            // Option 1: Delete s[left]
            if isPalindrome(s, left+1, right) {
                return true
            }
            // Option 2: Delete s[right]
            if isPalindrome(s, left, right-1) {
                return true
            }
            // If neither option works, it's not a valid palindrome with one deletion.
            return false
        }
    }
    // If the loop completes, it means the string is already a palindrome.
    return true
}

func isPalindrome(s string, left, right int) bool {
    for left < right {
        if s[left] == s[right] {
            left++
            right--
        } else {
            return false // Mismatch found, not a palindrome.
        }
    }
    return true // Substring is a palindrome.
}