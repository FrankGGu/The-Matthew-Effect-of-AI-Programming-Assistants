package main

func mostCommonWord(paragraph string, banned []string) string {
    wordCount := make(map[string]int)
    bannedSet := make(map[string]bool)
    for _, word := range banned {
        bannedSet[word] = true
    }

    var maxCount int
    var result string

    word := ""
    for i := 0; i < len(paragraph); i++ {
        if paragraph[i] >= 'a' && paragraph[i] <= 'z' {
            word += string(paragraph[i])
        } else if paragraph[i] >= 'A' && paragraph[i] <= 'Z' {
            word += string(paragraph[i] + 32)
        } else {
            if word != "" {
                if !bannedSet[word] {
                    wordCount[word]++
                    if wordCount[word] > maxCount {
                        maxCount = wordCount[word]
                        result = word
                    }
                }
                word = ""
            }
        }
    }

    if word != "" && !bannedSet[word] {
        wordCount[word]++
        if wordCount[word] > maxCount {
            result = word
        }
    }

    return result
}