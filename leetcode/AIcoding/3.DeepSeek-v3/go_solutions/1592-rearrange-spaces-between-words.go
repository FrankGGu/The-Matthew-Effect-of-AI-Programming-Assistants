func reorderSpaces(text string) string {
    words := []string{}
    spaceCount := 0
    currentWord := []rune{}

    for _, ch := range text {
        if ch == ' ' {
            spaceCount++
            if len(currentWord) > 0 {
                words = append(words, string(currentWord))
                currentWord = []rune{}
            }
        } else {
            currentWord = append(currentWord, ch)
        }
    }
    if len(currentWord) > 0 {
        words = append(words, string(currentWord))
    }

    wordCount := len(words)
    if wordCount == 1 {
        return words[0] + strings.Repeat(" ", spaceCount)
    }

    spacesBetween := spaceCount / (wordCount - 1)
    extraSpaces := spaceCount % (wordCount - 1)

    between := strings.Repeat(" ", spacesBetween)
    result := strings.Join(words, between)
    if extraSpaces > 0 {
        result += strings.Repeat(" ", extraSpaces)
    }

    return result
}