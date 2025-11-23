func countCompleteSubstrings(s string) int {
    n := len(s)
    count := 0

    for length := 1; length <= n; length++ {
        freq := make(map[rune]int)
        for i := 0; i < length; i++ {
            freq[rune(s[i])]++
        }
        if len(freq) == length {
            count++
        }

        for start := 1; start <= n-length; start++ {
            freq[rune(s[start-1])]--
            if freq[rune(s[start-1])] == 0 {
                delete(freq, rune(s[start-1]))
            }
            freq[rune(s[start+length-1])]++

            if len(freq) == length {
                count++
            }
        }
    }

    return count
}