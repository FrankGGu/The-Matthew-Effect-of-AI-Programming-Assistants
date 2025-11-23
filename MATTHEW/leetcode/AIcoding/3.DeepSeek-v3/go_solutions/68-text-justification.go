func fullJustify(words []string, maxWidth int) []string {
    var res []string
    n := len(words)
    i := 0

    for i < n {
        j := i + 1
        lineLength := len(words[i])

        for j < n && lineLength + 1 + len(words[j]) <= maxWidth {
            lineLength += 1 + len(words[j])
            j++
        }

        numWords := j - i
        totalSpaces := maxWidth - lineLength + (numWords - 1)

        if numWords == 1 || j == n {
            res = append(res, leftJustify(words, i, j, maxWidth))
        } else {
            res = append(res, middleJustify(words, i, j, totalSpaces))
        }

        i = j
    }

    return res
}

func leftJustify(words []string, i, j, maxWidth int) string {
    line := words[i]
    for k := i + 1; k < j; k++ {
        line += " " + words[k]
    }
    for len(line) < maxWidth {
        line += " "
    }
    return line
}

func middleJustify(words []string, i, j, totalSpaces int) string {
    numWords := j - i
    numGaps := numWords - 1
    spacesPerGap := totalSpaces / numGaps
    extraSpaces := totalSpaces % numGaps

    line := words[i]
    for k := i + 1; k < j; k++ {
        spaces := spacesPerGap
        if extraSpaces > 0 {
            spaces++
            extraSpaces--
        }
        for s := 0; s < spaces; s++ {
            line += " "
        }
        line += words[k]
    }
    return line
}