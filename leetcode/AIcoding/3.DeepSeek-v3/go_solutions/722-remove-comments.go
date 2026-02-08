func removeComments(source []string) []string {
    inBlock := false
    var buf strings.Builder
    var res []string

    for _, line := range source {
        if !inBlock {
            buf.Reset()
        }
        i := 0
        n := len(line)
        for i < n {
            if !inBlock && i+1 < n && line[i] == '/' && line[i+1] == '*' {
                inBlock = true
                i += 2
            } else if inBlock && i+1 < n && line[i] == '*' && line[i+1] == '/' {
                inBlock = false
                i += 2
            } else if !inBlock && i+1 < n && line[i] == '/' && line[i+1] == '/' {
                break
            } else if !inBlock {
                buf.WriteByte(line[i])
                i++
            } else {
                i++
            }
        }
        if !inBlock && buf.Len() > 0 {
            res = append(res, buf.String())
        }
    }
    return res
}