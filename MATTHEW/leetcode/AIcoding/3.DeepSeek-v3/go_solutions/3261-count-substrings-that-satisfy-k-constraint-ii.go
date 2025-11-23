func countSubstrings(s string, k int) int64 {
    n := len(s)
    var res int64
    for i := 0; i < n; i++ {
        freq := make([]int, 26)
        distinct := 0
        for j := i; j < n; j++ {
            idx := s[j] - 'a'
            if freq[idx] == 0 {
                distinct++
            }
            freq[idx]++
            if distinct >= k {
                res++
            }
        }
    }
    return res
}