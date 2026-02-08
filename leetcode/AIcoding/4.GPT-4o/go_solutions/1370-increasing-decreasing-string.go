func sortString(s string) string {
    freq := [26]int{}
    for _, ch := range s {
        freq[ch-'a']++
    }

    result := []byte{}
    for len(result) < len(s) {
        for i := 0; i < 26; i++ {
            if freq[i] > 0 {
                result = append(result, byte(i+'a'))
                freq[i]--
            }
        }
        for i := 25; i >= 0; i-- {
            if freq[i] > 0 {
                result = append(result, byte(i+'a'))
                freq[i]--
            }
        }
    }

    return string(result)
}