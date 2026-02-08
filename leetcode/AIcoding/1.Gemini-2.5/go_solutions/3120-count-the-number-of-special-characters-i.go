func numberOfSpecialChars(word string) int {
    seenLower := [26]bool{}
    seenUpper := [26]bool{}

    for _, r := range word {
        if r >= 'a' && r <= 'z' {
            seenLower[r - 'a'] = true
        } else if r >= 'A' && r <= 'Z' {
            seenUpper[r - 'A'] = true
        }
    }

    count := 0
    for i := 0; i < 26; i++ {
        if seenLower[i] && seenUpper[i] {
            count++
        }
    }
    return count
}