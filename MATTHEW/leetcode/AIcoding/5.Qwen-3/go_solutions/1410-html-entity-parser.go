package main

func entityParser(text string) string {
    entityMap := map[string]string{
        "&quot;": "\"",
        "&apos;": "'",
        "&amp;":  "&",
        "&gt;":   ">",
        "&lt;":   "<",
        "&frasl;": "/",
    }

    result := []rune{}
    i := 0
    for i < len(text) {
        if text[i] == '&' {
            found := false
            for j := i + 1; j <= len(text); j++ {
                if j-i > 12 {
                    break
                }
                if j < len(text) && text[j] == ';' {
                    entity := text[i:j+1]
                    if replacement, ok := entityMap[entity]; ok {
                        result = append(result, []rune(replacement)...)
                    } else {
                        result = append(result, []rune(entity)...)
                    }
                    i = j + 1
                    found = true
                    break
                }
            }
            if !found {
                result = append(result, '&')
                i++
            }
        } else {
            result = append(result, rune(text[i]))
            i++
        }
    }
    return string(result)
}