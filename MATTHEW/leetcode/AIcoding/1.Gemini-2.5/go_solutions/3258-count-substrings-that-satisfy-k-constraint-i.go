func countSubstrings(s string, k int) int {
    n := len(s)
    count := 0

    for i := 0; i < n; i++ {
        freq := make(map[byte]int)
        distinctCount := 0
        for j := i; j < n; j++ {
            char := s[j]
            if freq[char] == 0 {
                distinctCount++
            }
            freq[char]++

            if distinctCount >= k {
                count++
            }
        }
    }
    return count
}