import (
    "strings"
    "unicode"
)

func mostCommonWord(paragraph string, banned []string) string {
    wordCount := make(map[string]int)
    bannedMap := make(map[string]struct{})

    for _, word := range banned {
        bannedMap[strings.ToLower(word)] = struct{}{}
    }

    paragraph = strings.ToLower(paragraph)
    var sb strings.Builder

    for _, ch := range paragraph {
        if unicode.IsLetter(ch) {
            sb.WriteRune(ch)
        } else {
            if sb.Len() > 0 {
                word := sb.String()
                if _, exists := bannedMap[word]; !exists {
                    wordCount[word]++
                }
                sb.Reset()
            }
        }
    }

    if sb.Len() > 0 {
        word := sb.String()
        if _, exists := bannedMap[word]; !exists {
            wordCount[word]++
        }
    }

    maxCount := 0
    mostCommon := ""
    for word, count := range wordCount {
        if count > maxCount {
            maxCount = count
            mostCommon = word
        }
    }

    return mostCommon
}