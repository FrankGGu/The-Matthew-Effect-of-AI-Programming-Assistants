func countKSubstrings(s string, k int) int {
    count := 0
    freq := make(map[byte]int)
    l := 0

    for r := 0; r < len(s); r++ {
        freq[s[r]]++

        for len(freq) > k {
            freq[s[l]]--
            if freq[s[l]] == 0 {
                delete(freq, s[l])
            }
            l++
        }

        if len(freq) == k {
            count++
        }
    }

    return count
}