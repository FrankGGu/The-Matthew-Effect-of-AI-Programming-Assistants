func numberOfSpecialChars(word string) int {
    lower := make([]int, 26)
    upper := make([]int, 26)

    for i := 0; i < len(word); i++ {
        c := word[i]
        if c >= 'a' && c <= 'z' {
            lower[c - 'a'] = i + 1
        } else {
            if upper[c - 'A'] == 0 {
                upper[c - 'A'] = i + 1
            }
        }
    }

    count := 0
    for i := 0; i < 26; i++ {
        if lower[i] != 0 && upper[i] != 0 && lower[i] < upper[i] {
            count++
        }
    }
    return count
}