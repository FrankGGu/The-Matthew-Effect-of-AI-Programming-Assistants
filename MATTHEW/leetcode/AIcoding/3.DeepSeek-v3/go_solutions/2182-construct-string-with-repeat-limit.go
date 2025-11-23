func repeatLimitedString(s string, repeatLimit int) string {
    freq := make([]int, 26)
    for _, ch := range s {
        freq[ch-'a']++
    }

    res := make([]byte, 0)
    for i := 25; i >= 0; i-- {
        if freq[i] == 0 {
            continue
        }
        for j := 0; j < repeatLimit && freq[i] > 0; j++ {
            res = append(res, byte(i+'a'))
            freq[i]--
        }
        if freq[i] > 0 {
            found := false
            for k := i-1; k >= 0; k-- {
                if freq[k] > 0 {
                    res = append(res, byte(k+'a'))
                    freq[k]--
                    found = true
                    break
                }
            }
            if found {
                i++
            } else {
                break
            }
        }
    }
    return string(res)
}