func maximumLengthSubstring(s string) int {
    maxLen := 0
    left := 0
    freq := make(map[byte]int)

    for right := 0; right < len(s); right++ {
        freq[s[right]]++

        for freq[s[right]] > 2 {
            freq[s[left]]--
            if freq[s[left]] == 0 {
                delete(freq, s[left])
            }
            left++
        }

        if right - left + 1 > maxLen {
            maxLen = right - left + 1
        }
    }

    return maxLen
}