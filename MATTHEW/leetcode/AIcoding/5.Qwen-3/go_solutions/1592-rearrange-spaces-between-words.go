package main

func reorderSpaces(words []string, maxWidth int) []string {
    if len(words) == 0 {
        return []string{strings.Repeat(" ", maxWidth)}
    }

    totalSpaces := maxWidth
    for _, word := range words {
        totalSpaces -= len(word)
    }

    if len(words) == 1 {
        return []string{words[0] + strings.Repeat(" ", totalSpaces)}
    }

    spaceBetween := totalSpaces / (len(words) - 1)
    extraSpaces := totalSpaces % (len(words) - 1)

    result := make([]string, 0, 1)
    line := ""

    for i, word := range words {
        line += word
        if i < len(words)-1 {
            line += strings.Repeat(" ", spaceBetween)
            if extraSpaces > 0 {
                line += " "
                extraSpaces--
            }
        }
    }

    result = append(result, line)
    return result
}