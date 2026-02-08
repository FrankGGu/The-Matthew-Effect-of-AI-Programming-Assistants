func countSubstrings(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    count := 0

    for i := 0; i < n; i++ {
        // Odd length palindromes, center is s[i]
        left, right := i, i
        for left >= 0 && right < n && s[left] == s[right] {
            count++
            left--
            right++
        }

        // Even length palindromes, center is between s[i] and s[i+1]
        left, right = i, i+1
        for left >= 0 && right < n && s[left] == s[right] {
            count++
            left--
            right++
        }
    }

    return count
}