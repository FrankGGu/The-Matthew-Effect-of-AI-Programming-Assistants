func checkDistances(s string, distance []int) bool {
    firstOccurrence := make(map[rune]int)
    for i, ch := range s {
        if pos, exists := firstOccurrence[ch]; exists {
            expected := distance[ch - 'a']
            if i - pos - 1 != expected {
                return false
            }
        } else {
            firstOccurrence[ch] = i
        }
    }
    return true
}