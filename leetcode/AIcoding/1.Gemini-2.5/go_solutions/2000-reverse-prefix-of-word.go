func reversePrefix(word string, ch byte) string {
    sBytes := []byte(word)

    idx := -1
    for i := 0; i < len(sBytes); i++ {
        if sBytes[i] == ch {
            idx = i
            break
        }
    }

    if idx == -1 {
        return word
    }

    left := 0
    right := idx
    for left < right {
        sBytes[left], sBytes[right] = sBytes[right], sBytes[left]
        left++
        right--
    }

    return string(sBytes)
}