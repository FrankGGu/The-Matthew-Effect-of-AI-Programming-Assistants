func repeatLimitedString(s string, rLimit int) string {
    freq := make([]int, 26)
    for _, ch := range s {
        freq[ch-'a']++
    }

    result := []byte{}
    for {
        found := false
        for i := 25; i >= 0; i-- {
            if freq[i] == 0 {
                continue
            }
            if len(result) >= rLimit && result[len(result)-1] == byte(i+'a') {
                if i == 0 {
                    return string(result)
                }
                for j := i - 1; j >= 0; j-- {
                    if freq[j] > 0 {
                        result = append(result, byte(j+'a'))
                        freq[j]--
                        break
                    }
                }
                freq[i]--
                result = append(result, byte(i+'a'))
                found = true
            } else {
                result = append(result, byte(i+'a'))
                freq[i]--
                found = true
            }
            if found {
                break
            }
        }
        if !found {
            break
        }
    }
    return string(result)
}