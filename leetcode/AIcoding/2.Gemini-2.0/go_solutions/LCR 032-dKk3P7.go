func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    sMap := make(map[rune]int)
    tMap := make(map[rune]int)

    for _, char := range s {
        sMap[char]++
    }

    for _, char := range t {
        tMap[char]++
    }

    for char, count := range sMap {
        if tMap[char] != count {
            return false
        }
    }

    return true
}