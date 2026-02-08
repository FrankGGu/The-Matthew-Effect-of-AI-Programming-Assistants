func entityParser(text string) string {
    entities := map[string]string{
        "&quot;":  "\"",
        "&apos;":  "'",
        "&amp;":   "&",
        "&gt;":    ">",
        "&lt;":    "<",
        "&frasl;": "/",
    }

    res := []byte{}
    i := 0
    n := len(text)

    for i < n {
        if text[i] == '&' {
            found := false
            for k, v := range entities {
                if i+len(k) <= n && text[i:i+len(k)] == k {
                    res = append(res, []byte(v)...)
                    i += len(k)
                    found = true
                    break
                }
            }
            if !found {
                res = append(res, text[i])
                i++
            }
        } else {
            res = append(res, text[i])
            i++
        }
    }

    return string(res)
}