package main

func fullJustify(words []string, maxWidth int) []string {
    result := []string{}
    line := []string{}
    lineWidth := 0

    for _, word := range words {
        if len(line)+len(word)+lineWidth > maxWidth {
            spaces := maxWidth - lineWidth
            if len(line) == 1 {
                line[0] += getSpaces(spaces)
            } else {
                gap := len(line) - 1
                spacePerGap := spaces / gap
                extraSpace := spaces % gap
                for i := 0; i < len(line); i++ {
                    if i < extraSpace {
                        line[i] += getSpaces(spacePerGap + 1)
                    } else {
                        line[i] += getSpaces(spacePerGap)
                    }
                }
            }
            result = append(result, join(line))
            line = []string{word}
            lineWidth = len(word)
        } else {
            line = append(line, word)
            lineWidth += len(word)
        }
    }

    lastLine := join(line)
    lastLine += getSpaces(maxWidth - len(lastLine))
    result = append(result, lastLine)

    return result
}

func getSpaces(n int) string {
    s := ""
    for i := 0; i < n; i++ {
        s += " "
    }
    return s
}

func join(words []string) string {
    s := ""
    for i := 0; i < len(words); i++ {
        s += words[i]
        if i < len(words)-1 {
            s += " "
        }
    }
    return s
}