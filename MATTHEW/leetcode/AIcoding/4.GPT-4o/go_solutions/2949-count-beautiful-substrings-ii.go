func countBeautifulSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    freq := make(map[string]int)
    freq[""] = 1
    current := 0

    for i := 0; i < n; i++ {
        if s[i] == '1' {
            current++
        } else {
            current--
        }
        if i >= k-1 {
            count += freq[fmt.Sprintf("%d", current)]
            freq[fmt.Sprintf("%d", current)]++
            if s[i-k+1] == '1' {
                current--
            } else {
                current++
            }
        }
    }

    return count
}