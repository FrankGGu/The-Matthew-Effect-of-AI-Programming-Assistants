func detectCapitalUse(word string) bool {
    if len(word) == 0 {
        return false
    }
    isAllUpper := true
    isAllLower := true
    isFirstUpper := word[0] >= 'A' && word[0] <= 'Z'

    for i := 0; i < len(word); i++ {
        if word[i] >= 'A' && word[i] <= 'Z' {
            isAllLower = false
        } else {
            isAllUpper = false
        }
    }

    if isAllUpper || isAllLower {
        return true
    }

    return isFirstUpper && isAllLower
}