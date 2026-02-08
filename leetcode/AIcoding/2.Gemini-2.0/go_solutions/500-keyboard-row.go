func findWords(words []string) []string {
    rows := []string{"qwertyuiop", "asdfghjkl", "zxcvbnm"}
    rowMap := make(map[rune]int)
    for i, row := range rows {
        for _, char := range row {
            rowMap[char] = i
        }
    }

    result := []string{}
    for _, word := range words {
        lowerWord := []rune(strings.ToLower(word))
        row := rowMap[lowerWord[0]]
        valid := true
        for _, char := range lowerWord {
            if rowMap[char] != row {
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