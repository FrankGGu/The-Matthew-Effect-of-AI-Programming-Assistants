func entityParser(text string) string {
    entities := map[string]string{
        "&quot;": "\"",
        "&apos;": "'",
        "&amp;":  "&",
        "&gt;":   ">",
        "&lt;":   "<",
    }

    result := ""
    i := 0
    for i < len(text) {
        if text[i] == '&' {
            j := i + 1
            for j < len(text) && text[j] != ';' {
                j++
            }
            if j < len(text) {
                entity := text[i:j+1]
                if val, ok := entities[entity]; ok {
                    result += val
                    i = j + 1
                    continue
                }
            }
        }
        result += string(text[i])
        i++
    }

    return result
}