func countSubstrings(s string, k int) int {
    n := len(s)
    res := 0
    for i := 0; i < n; i++ {
        freq := make([]int, 26)
        maxFreq := 0
        for j := i; j < n; j++ {
            freq[s[j]-'a']++
            if freq[s[j]-'a'] > maxFreq {
                maxFreq = freq[s[j]-'a']
            }
            if maxFreq >= k {
                res++
            }
        }
    }
    return res
}