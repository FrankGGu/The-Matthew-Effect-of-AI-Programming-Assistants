func splitMessage(message string, limit int) []string {
    n := len(message)
    parts := 0
    var res []string

    for parts = 1; parts <= n; parts++ {
        suffixLen := len(fmt.Sprintf("<%d/%d>", parts, parts))
        if suffixLen + 1 > limit {
            return []string{}
        }
        total := 0
        for i := 1; i <= parts; i++ {
            suffix := fmt.Sprintf("<%d/%d>", i, parts)
            suffixLen := len(suffix)
            if suffixLen >= limit {
                return []string{}
            }
            chunkSize := limit - suffixLen
            total += chunkSize
            if total >= n {
                break
            }
        }
        if total >= n {
            break
        }
    }

    if parts > n {
        return []string{}
    }

    idx := 0
    for i := 1; i <= parts; i++ {
        suffix := fmt.Sprintf("<%d/%d>", i, parts)
        suffixLen := len(suffix)
        chunkSize := limit - suffixLen
        end := idx + chunkSize
        if end > n {
            end = n
        }
        chunk := message[idx:end] + suffix
        res = append(res, chunk)
        idx = end
    }

    return res
}