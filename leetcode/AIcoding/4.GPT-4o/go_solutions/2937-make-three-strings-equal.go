func makeEqual(words []string) bool {
    count := make([]int, 26)
    for _, word := range words {
        for _, ch := range word {
            count[ch-'a']++
        }
    }
    n := len(words)
    for _, c := range count {
        if c%n != 0 {
            return false
        }
    }
    return true
}