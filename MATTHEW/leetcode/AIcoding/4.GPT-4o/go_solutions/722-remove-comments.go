func removeComments(source []string) []string {
    result := []string{}
    inBlockComment := false
    currentLine := ""

    for _, line := range source {
        i := 0
        for i < len(line) {
            if !inBlockComment {
                if i+1 < len(line) && line[i] == '/' && line[i+1] == '*' {
                    inBlockComment = true
                    i += 2
                } else if i+1 < len(line) && line[i] == '/' && line[i+1] == '/' {
                    break
                } else {
                    currentLine += string(line[i])
                }
            } else {
                if i+1 < len(line) && line[i] == '*' && line[i+1] == '/' {
                    inBlockComment = false
                    i += 2
                }
            }
            i++
        }
        if !inBlockComment && currentLine != "" {
            result = append(result, currentLine)
            currentLine = ""
        }
    }
    return result
}