func maximumPalindromes(s string, k int) int {
    n := len(s)
    maxPalindromes := 0

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            substr := s[i:j+1]
            if isPalindrome(substr) {
                if len(substr) <= k {
                    maxPalindromes++
                }
            }
        }
    }

    return maxPalindromes
}

func isPalindrome(s string) bool {
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}