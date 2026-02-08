func sortString(s string) string {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    var res []byte
    for len(res) < len(s) {
        for i := 0; i < 26; i++ {
            if freq[i] > 0 {
                res = append(res, byte(i+'a'))
                freq[i]--
            }
        }
        for i := 25; i >= 0; i-- {
            if freq[i] > 0 {
                res = append(res, byte(i+'a'))
                freq[i]--
            }
        }
    }
    return string(res)
}