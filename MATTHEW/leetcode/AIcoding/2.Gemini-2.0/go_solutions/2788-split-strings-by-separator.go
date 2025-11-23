func split(s string, separator byte) []string {
    result := []string{}
    current := ""
    for i := 0; i < len(s); i++ {
        if s[i] == separator {
            if current != "" {
                result = append(result, current)
            }
            current = ""
        } else {
            current += string(s[i])
        }
    }
    if current != "" {
        result = append(result, current)
    }
    return result
}