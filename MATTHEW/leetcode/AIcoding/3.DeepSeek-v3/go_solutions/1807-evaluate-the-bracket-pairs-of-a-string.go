func evaluate(s string, knowledge [][]string) string {
    knowledgeMap := make(map[string]string)
    for _, pair := range knowledge {
        knowledgeMap[pair[0]] = pair[1]
    }

    var result strings.Builder
    i := 0
    n := len(s)

    for i < n {
        if s[i] == '(' {
            j := i + 1
            for j < n && s[j] != ')' {
                j++
            }
            key := s[i+1:j]
            if val, ok := knowledgeMap[key]; ok {
                result.WriteString(val)
            } else {
                result.WriteByte('?')
            }
            i = j + 1
        } else {
            result.WriteByte(s[i])
            i++
        }
    }

    return result.String()
}