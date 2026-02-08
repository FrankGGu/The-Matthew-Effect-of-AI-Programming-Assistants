import (
    "unicode"
)

func numDifferentIntegers(word string) int {
    seen := make(map[string]bool)
    current := []rune{}

    for _, ch := range word {
        if unicode.IsDigit(ch) {
            current = append(current, ch)
        } else {
            if len(current) > 0 {
                numStr := string(current)
                for len(numStr) > 1 && numStr[0] == '0' {
                    numStr = numStr[1:]
                }
                seen[numStr] = true
                current = []rune{}
            }
        }
    }

    if len(current) > 0 {
        numStr := string(current)
        for len(numStr) > 1 && numStr[0] == '0' {
            numStr = numStr[1:]
        }
        seen[numStr] = true
    }

    return len(seen)
}