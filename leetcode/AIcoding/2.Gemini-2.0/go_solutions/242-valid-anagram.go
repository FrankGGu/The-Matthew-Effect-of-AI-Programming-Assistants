func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    count := make(map[rune]int)
    for _, r := range s {
        count[r]++
    }

    for _, r := range t {
        count[r]--
        if count[r] < 0 {
            return false
        }
    }

    return true
}