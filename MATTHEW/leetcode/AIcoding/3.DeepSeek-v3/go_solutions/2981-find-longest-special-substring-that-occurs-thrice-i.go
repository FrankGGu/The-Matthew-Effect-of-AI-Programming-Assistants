func maximumLength(s string) int {
    n := len(s)
    freq := make(map[string]int)

    for i := 0; i < n; i++ {
        for j := i + 1; j <= n; j++ {
            substr := s[i:j]
            valid := true
            for k := 1; k < len(substr); k++ {
                if substr[k] != substr[0] {
                    valid = false
                    break
                }
            }
            if valid {
                freq[substr]++
            }
        }
    }

    maxLen := -1
    for key, cnt := range freq {
        if cnt >= 3 && len(key) > maxLen {
            maxLen = len(key)
        }
    }

    return maxLen
}