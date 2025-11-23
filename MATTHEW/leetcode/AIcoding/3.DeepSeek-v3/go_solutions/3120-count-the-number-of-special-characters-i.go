func numberOfSpecialChars(word string) int {
    lower := make([]bool, 26)
    upper := make([]bool, 26)

    for _, c := range word {
        if c >= 'a' && c <= 'z' {
            lower[c - 'a'] = true
        } else if c >= 'A' && c <= 'Z' {
            upper[c - 'A'] = true
        }
    }

    count := 0
    for i := 0; i < 26; i++ {
        if lower[i] && upper[i] {
            count++
        }
    }
    return count
}