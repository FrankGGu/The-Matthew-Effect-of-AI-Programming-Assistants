func findWords(words []string) []string {
    rows := []string{"qwertyuiop", "asdfghjkl", "zxcvbnm"}
    rowMap := make(map[rune]int)
    for i, row := range rows {
        for _, c := range row {
            rowMap[c] = i
        }
    }

    result := []string{}
    for _, word := range words {
        if len(word) == 0 {
            continue
        }
        lowerWord := strings.ToLower(word)
        row := rowMap[rune(lowerWord[0])]
        valid := true
        for _, c := range lowerWord {
            if rowMap[c] != row {
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