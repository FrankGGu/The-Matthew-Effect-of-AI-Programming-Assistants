func findTheString(s string) string {
    n := len(s)
    box := make([]byte, n)
    for i := 0; i < n; i++ {
        box[i] = 'a' + byte(i)
    }

    for i := 0; i < n; i++ {
        if s[i] == '0' {
            box[i] = 'a' + byte(n-1-i)
        }
    }

    return string(box)
}