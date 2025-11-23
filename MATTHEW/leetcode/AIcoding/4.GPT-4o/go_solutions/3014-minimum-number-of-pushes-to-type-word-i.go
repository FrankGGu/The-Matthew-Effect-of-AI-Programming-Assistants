func minimumPushes(word string) int {
    n := len(word)
    pushes := 0
    current := 'a'

    for i := 0; i < n; i++ {
        if word[i] != byte(current) {
            pushes++
            current = rune(word[i])
        }
    }
    return pushes
}