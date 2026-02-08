func smallestString(s string) string {
    bytes := []byte(s)
    n := len(bytes)
    i := 0
    for i < n && bytes[i] == 'a' {
        i++
    }
    if i == n {
        bytes[n-1] = 'z'
        return string(bytes)
    }
    for i < n && bytes[i] != 'a' {
        bytes[i]--
        i++
    }
    return string(bytes)
}