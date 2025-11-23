func breakCode(password string) string {
    n := len(password)
    if n == 0 {
        return ""
    }

    result := make([]rune, n)
    for i, ch := range password {
        result[i] = 'z' - (ch - 'a')
    }

    return string(result)
}