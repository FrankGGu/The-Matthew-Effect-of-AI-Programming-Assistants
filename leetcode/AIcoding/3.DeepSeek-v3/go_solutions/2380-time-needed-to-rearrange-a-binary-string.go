func secondsToRemoveOccurrences(s string) int {
    seconds := 0
    for {
        changed := false
        bytes := []byte(s)
        for i := 0; i < len(bytes)-1; i++ {
            if bytes[i] == '0' && bytes[i+1] == '1' {
                bytes[i], bytes[i+1] = bytes[i+1], bytes[i]
                i++
                changed = true
            }
        }
        if !changed {
            break
        }
        seconds++
        s = string(bytes)
    }
    return seconds
}