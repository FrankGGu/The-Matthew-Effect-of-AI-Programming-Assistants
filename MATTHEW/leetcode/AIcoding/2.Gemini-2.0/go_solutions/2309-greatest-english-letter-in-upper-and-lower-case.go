func greatestLetter(s string) string {
    upper := make(map[rune]bool)
    lower := make(map[rune]bool)

    for _, r := range s {
        if r >= 'a' && r <= 'z' {
            lower[r] = true
        } else if r >= 'A' && r <= 'Z' {
            upper[r] = true
        }
    }

    result := ""
    for i := 'Z'; i >= 'A'; i-- {
        if upper[i] && lower[i+'a'-'A'] {
            result = string(i)
            break
        }
    }

    return result
}