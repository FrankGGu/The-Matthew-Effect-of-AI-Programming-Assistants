func minimumPushes(word string) int {
    length := len(word)
    presses := 0
    for i := 0; i < length; i++ {
        presses += (i / 8) + 1
    }
    return presses
}