func smallestString(s string) string {
    bs := []byte(s)
    n := len(bs)
    for i := 0; i < n; i++ {
        if bs[i] != 'a' {
            for j := i; j < n && bs[j] != 'a'; j++ {
                bs[j]--
            }
            return string(bs)
        }
    }
    bs[n-1] = 'z'
    return string(bs)
}