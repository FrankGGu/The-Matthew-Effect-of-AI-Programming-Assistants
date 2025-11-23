func makeEqual(words []string) bool {
    count := make([]int, 26)
    for _, word := range words {
        for _, c := range word {
            count[c-'a']++
        }
    }
    n := len(words)
    for _, v := range count {
        if v%n != 0 {
            return false
        }
    }
    return true
}