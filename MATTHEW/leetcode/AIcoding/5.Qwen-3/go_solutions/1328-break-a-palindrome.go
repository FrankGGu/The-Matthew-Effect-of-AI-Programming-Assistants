package main

func breakPalindrome(palindrome string) string {
    n := len(palindrome)
    if n == 1 {
        return ""
    }
    for i := 0; i < n/2; i++ {
        if palindrome[i] != 'a' {
            return palindrome[:i] + "a" + palindrome[i+1:]
        }
    }
    return palindrome[:n-1] + "b"
}