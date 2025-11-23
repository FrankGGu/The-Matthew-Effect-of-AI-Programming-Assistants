import (
    "strings"
    "unicode"
)

func mostCommonWord(paragraph string, banned []string) string {
    bannedSet := make(map[string]bool)
    for _, word := range banned {
        bannedSet[word] = true
    }

    freq := make(map[string]int)
    var builder strings.Builder

    for _, ch := range paragraph {
        if unicode.IsLetter(ch) {
            builder.WriteRune(unicode.ToLower(ch))
        } else if builder.Len() > 0 {
            word := builder.String()
            if !bannedSet[word] {
                freq[word]++
            }
            builder.Reset()
        }
    }

    if builder.Len() > 0 {
        word := builder.String()
        if !bannedSet[word] {
            freq[word]++
        }
    }

    maxFreq := 0
    result := ""
    for word, count := range freq {
        if count > maxFreq {
            maxFreq = count
            result = word
        }
    }

    return result
}