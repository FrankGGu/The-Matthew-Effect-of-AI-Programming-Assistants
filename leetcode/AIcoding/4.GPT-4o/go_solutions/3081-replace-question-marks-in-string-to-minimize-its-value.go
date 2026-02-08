func minValue(s string) string {
    b := []byte(s)
    for i := 0; i < len(b); i++ {
        if b[i] == '?' {
            if i == 0 {
                b[i] = 'a'
            } else {
                used := map[byte]bool{}
                if b[i-1] != '?' {
                    used[b[i-1]] = true
                }
                if i < len(b)-1 && b[i+1] != '?' {
                    used[b[i+1]] = true
                }
                for ch := byte('a'); ch <= 'c'; ch++ {
                    if !used[ch] {
                        b[i] = ch
                        break
                    }
                }
            }
        }
    }
    return string(b)
}