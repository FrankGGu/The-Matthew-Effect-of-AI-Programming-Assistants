func calculateTime(keyboard string, word string) int {
    keyIndex := make(map[rune]int)
    for i, char := range keyboard {
        keyIndex[char] = i
    }

    time := 0
    currentPos := 0
    for _, char := range word {
        time += abs(keyIndex[char] - currentPos)
        currentPos = keyIndex[char]
    }
    return time
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}