func countValidWords(sentence string) int {
    words := strings.Fields(sentence)
    count := 0

    for _, word := range words {
        if isValid(word) {
            count++
        }
    }

    return count
}

func isValid(word string) bool {
    hasHyphen := false
    hasPunct := false
    n := len(word)

    for i := 0; i < n; i++ {
        if !isLetter(word[i]) && !isDigit(word[i]) {
            if word[i] == '-' {
                if hasHyphen || i == 0 || i == n-1 || !isLetter(word[i-1]) || !isLetter(word[i+1]) {
                    return false
                }
                hasHyphen = true
            } else if isPunctuation(word[i]) {
                if hasPunct || i != n-1 {
                    return false
                }
                hasPunct = true
            } else {
                return false
            }
        }
    }

    return true
}

func isLetter(c byte) bool {
    return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}

func isDigit(c byte) bool {
    return c >= '0' && c <= '9'
}

func isPunctuation(c byte) bool {
    return c == '.' || c == ',' || c == '!'
}