package main

func reorderLogFiles(logs []string) []string {
    var letters, digits []string

    for _, log := range logs {
        if isLetterLog(log) {
            letters = append(letters, log)
        } else {
            digits = append(digits, log)
        }
    }

    sort.Slice(letters, func(i, j int) bool {
        a, b := letters[i], letters[j]
        aContent := a[strings.IndexByte(a, ' ')+1:]
        bContent := b[strings.IndexByte(b, ' ')+1:]
        if aContent != bContent {
            return aContent < bContent
        }
        return a < b
    })

    return append(letters, digits...)
}

func isLetterLog(log string) bool {
    for i, c := range log {
        if c == ' ' {
            return log[i+1] >= 'a' && log[i+1] <= 'z'
        }
    }
    return false
}