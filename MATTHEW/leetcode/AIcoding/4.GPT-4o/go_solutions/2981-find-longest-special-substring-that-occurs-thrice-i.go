func longestSpecialSubstring(s string) string {
    n := len(s)
    longest := ""

    for length := 1; length <= n/3; length++ {
        count := make(map[string]int)
        for i := 0; i <= n-length; i++ {
            substr := s[i : i+length]
            count[substr]++
        }

        for substr, cnt := range count {
            if cnt == 3 && len(substr) > len(longest) {
                longest = substr
            }
        }
    }

    return longest
}