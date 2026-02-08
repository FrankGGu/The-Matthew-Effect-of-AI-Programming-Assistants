func checkDistances(s string, distance []int) bool {
    lastIndex := make(map[rune]int)

    for i, ch := range s {
        if lastIdx, found := lastIndex[ch]; found {
            if i-lastIdx-1 != distance[ch-'a'] {
                return false
            }
        }
        lastIndex[ch] = i
    }

    return true
}