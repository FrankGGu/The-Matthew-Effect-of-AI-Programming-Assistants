func modifyString(s string) string {
    res := []byte(s)
    n := len(res)
    for i := 0; i < n; i++ {
        if res[i] == '?' {
            for c := byte('a'); c <= 'c'; c++ {
                if (i == 0 || res[i-1] != c) && (i == n-1 || res[i+1] != c) {
                    res[i] = c
                    break
                }
            }
        }
    }
    return string(res)
}