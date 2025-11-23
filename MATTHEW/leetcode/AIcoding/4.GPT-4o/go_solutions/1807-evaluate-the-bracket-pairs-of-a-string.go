func evaluate(s string, knowledge [][]string) string {
    knowledgeMap := make(map[string]string)
    for _, k := range knowledge {
        knowledgeMap[k[0]] = k[1]
    }

    var result strings.Builder
    n := len(s)
    i := 0

    for i < n {
        if s[i] == '(' {
            j := i + 1
            for j < n && s[j] != ')' {
                j++
            }
            key := s[i+1 : j]
            if val, ok := knowledgeMap[key]; ok {
                result.WriteString(val)
            } else {
                result.WriteString("?")
            }
            i = j + 1
        } else {
            result.WriteByte(s[i])
            i++
        }
    }

    return result.String()
}