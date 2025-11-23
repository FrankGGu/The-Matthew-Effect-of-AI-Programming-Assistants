func countSubstrings(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    n := len(s)
    res := 0

    for i := 0; i < n; i++ {
        vowelCount := 0
        consonantCount := 0
        for j := i; j < n; j++ {
            if vowels[s[j]] {
                vowelCount++
            } else {
                consonantCount++
            }
            if vowelCount >= 5 && consonantCount == k {
                res++
            }
        }
    }

    return res
}