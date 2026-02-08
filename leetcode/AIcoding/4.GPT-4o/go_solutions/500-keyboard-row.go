func findWords(words []string) []string {
    rows := []string{"qwertyuiop", "asdfghjkl", "zxcvbnm"}
    rowMap := make(map[rune]int)

    for i, row := range rows {
        for _, char := range row {
            rowMap[char] = i
        }
    }

    var result []string
    for _, word := range words {
        firstRow := rowMap[rune(unicode.ToLower(rune(word[0])))]
        valid := true

        for _, char := range word {
            if rowMap[rune(unicode.ToLower(char))] != firstRow {
                valid = false
                break
            }
        }

        if valid {
            result = append(result, word)
        }
    }

    return result
}