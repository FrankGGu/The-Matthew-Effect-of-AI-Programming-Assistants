func countBeautifulSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    freq := make(map[rune]int)

    for i := 0; i < n; i++ {
        freq = make(map[rune]int)
        uniqueCount := 0
        for j := i; j < n; j++ {
            if freq[rune(s[j])] == 0 {
                uniqueCount++
            }
            freq[rune(s[j])]++
            if uniqueCount == k {
                count++
            }
            if uniqueCount > k {
                break
            }
        }
    }
    return count
}