func detectCapitalUse(word string) bool {
    if len(word) == 1 {
        return true
    }

    firstUpper := word[0] >= 'A' && word[0] <= 'Z'
    allUpper := true
    allLower := true

    for i := 1; i < len(word); i++ {
        if word[i] >= 'A' && word[i] <= 'Z' {
            allLower = false
        } else {
            allUpper = false
        }
    }

    return (firstUpper && allUpper) || allLower
}