func generateDynamicPassword(n int) string {
    if n < 1 {
        return ""
    }
    password := make([]byte, n)
    for i := 0; i < n; i++ {
        password[i] = byte('A' + i%26)
    }
    return string(password)
}