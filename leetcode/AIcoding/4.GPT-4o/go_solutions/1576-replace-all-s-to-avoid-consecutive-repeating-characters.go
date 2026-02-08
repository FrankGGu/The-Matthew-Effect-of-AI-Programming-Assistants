func modifyString(s string) string {
    n := len(s)
    chars := []byte(s)

    for i := 0; i < n; i++ {
        if chars[i] == '?' {
            for c := 'a'; c <= 'z'; c++ {
                if (i == 0 || chars[i-1] != byte(c)) && (i == n-1 || chars[i+1] != byte(c)) {
                    chars[i] = byte(c)
                    break
                }
            }
        }
    }

    return string(chars)
}