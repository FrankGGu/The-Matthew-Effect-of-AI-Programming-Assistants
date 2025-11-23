func beautifulSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        vowels := 0
        consonants := 0
        for j := i; j < n; j++ {
            c := s[j]
            if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                vowels++
            } else {
                consonants++
            }
            if vowels == consonants && (vowels * consonants) % k == 0 {
                count++
            }
        }
    }
    return count
}