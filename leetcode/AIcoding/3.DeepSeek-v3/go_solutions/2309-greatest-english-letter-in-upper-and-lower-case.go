func greatestLetter(s string) string {
    upper := make([]bool, 26)
    lower := make([]bool, 26)

    for _, c := range s {
        if c >= 'A' && c <= 'Z' {
            upper[c - 'A'] = true
        } else if c >= 'a' && c <= 'z' {
            lower[c - 'a'] = true
        }
    }

    for i := 25; i >= 0; i-- {
        if upper[i] && lower[i] {
            return string('A' + i)
        }
    }

    return ""
}