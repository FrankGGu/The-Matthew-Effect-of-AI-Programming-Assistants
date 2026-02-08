func countSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        freq := make([]int, 26)
        uniqueCount := 0
        for j := i; j < n; j++ {
            if freq[s[j]-'a'] == 0 {
                uniqueCount++
            }
            freq[s[j]-'a']++
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