func strStr(haystack string, needle string) int {
    n := len(needle)
    if n == 0 {
        return 0
    }
    h := len(haystack)
    if h < n {
        return -1
    }
    for i := 0; i <= h - n; i++ {
        if haystack[i:i+n] == needle {
            return i
        }
    }
    return -1
}