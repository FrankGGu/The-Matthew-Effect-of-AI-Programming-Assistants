func lengthOfLastWord(s string) int {
    length := 0
    foundWord := false
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] != ' ' {
            length++
            foundWord = true
        } else if foundWord {
            break
        }
    }
    return length
}