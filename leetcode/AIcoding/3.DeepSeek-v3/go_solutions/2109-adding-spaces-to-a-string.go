func addSpaces(s string, spaces []int) string {
    result := make([]byte, len(s)+len(spaces))
    spacePtr, strPtr := 0, 0
    for i := 0; i < len(result); i++ {
        if spacePtr < len(spaces) && strPtr == spaces[spacePtr] {
            result[i] = ' '
            spacePtr++
        } else {
            result[i] = s[strPtr]
            strPtr++
        }
    }
    return string(result)
}