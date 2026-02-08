func countSubstrings(s string, k int) int {
    vowels := map[byte]bool{'a': true, 'e': true, 'i': true, 'o': true, 'u': true}
    n := len(s)
    res := 0

    for i := 0; i < n; i++ {
        vowelCount := make(map[byte]int)
        consonantCount := 0
        for j := i; j < n; j++ {
            char := s[j]
            if vowels[char] {
                vowelCount[char]++
            } else {
                consonantCount++
            }
            if len(vowelCount) == 5 && consonantCount == k {
                res++
            }
        }
    }

    return res
}