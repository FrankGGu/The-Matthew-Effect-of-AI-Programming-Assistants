func rearrangeSpaces(text string) string {
    words := strings.Fields(text)
    spaceCount := 0

    for _, ch := range text {
        if ch == ' ' {
            spaceCount++
        }
    }

    if len(words) == 1 {
        return words[0] + strings.Repeat(" ", spaceCount)
    }

    spaceBetweenWords := spaceCount / (len(words) - 1)
    extraSpaces := spaceCount % (len(words) - 1)

    result := strings.Join(words, strings.Repeat(" ", spaceBetweenWords))
    result += strings.Repeat(" ", extraSpaces)

    return result
}