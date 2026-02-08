func countSubstrings(s string, k int) int {
    n := len(s)
    count := 0
    freq := make(map[rune]int)

    left := 0
    for right := 0; right < n; right++ {
        freq[rune(s[right])]++

        for len(freq) > k {
            freq[rune(s[left])]--
            if freq[rune(s[left])] == 0 {
                delete(freq, rune(s[left]))
            }
            left++
        }

        count += right - left + 1
    }

    return count
}