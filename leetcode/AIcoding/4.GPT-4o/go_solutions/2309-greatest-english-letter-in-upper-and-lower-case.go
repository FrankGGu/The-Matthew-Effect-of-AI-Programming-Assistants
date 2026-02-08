func greatestLetter(s string) string {
    upper := [26]bool{}
    lower := [26]bool{}

    for _, char := range s {
        if char >= 'A' && char <= 'Z' {
            upper[char-'A'] = true
        } else if char >= 'a' && char <= 'z' {
            lower[char-'a'] = true
        }
    }

    for i := 25; i >= 0; i-- {
        if upper[i] && lower[i] {
            return string('A' + i)
        }
    }

    return ""
}