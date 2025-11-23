func minTimeToType(word string) int {
    time := 0
    currentPos := 'a'

    for _, char := range word {
        diff := int(char - currentPos)
        if diff < 0 {
            diff += 26
        }
        time += diff + 1
        currentPos = char
    }

    return time
}