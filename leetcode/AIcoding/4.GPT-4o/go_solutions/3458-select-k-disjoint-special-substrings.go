func countSpecialSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        freq := make(map[byte]int)
        specialCount := 0
        for j := i; j < n; j++ {
            freq[s[j]]++
            if freq[s[j]] == 1 {
                specialCount++
            }
            if specialCount > k {
                break
            }
            if specialCount == k {
                count++
            }
        }
    }
    return count
}