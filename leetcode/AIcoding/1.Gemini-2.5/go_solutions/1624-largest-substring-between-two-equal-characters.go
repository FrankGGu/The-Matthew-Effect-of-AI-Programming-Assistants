func maxLengthBetweenEqualCharacters(s string) int {
    firstOccurrence := make(map[rune]int)
    maxLength := -1

    for i, char := range s {
        if firstIdx, ok := firstOccurrence[char]; ok {
            currentLength := i - firstIdx - 1
            if currentLength > maxLength {
                maxLength = currentLength
            }
        } else {
            firstOccurrence[char] = i
        }
    }

    return maxLength
}