func checkPartitioning(s string) bool {
    n := len(s)
    if n < 3 {
        return false // Cannot partition into three non-empty substrings
    }

    // isPalindrome[i][j] will be true if substring s[i...j] is a palindrome
    isPalindrome := make([][]