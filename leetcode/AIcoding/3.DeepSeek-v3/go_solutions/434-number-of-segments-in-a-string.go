func countSegments(s string) int {
    count := 0
    inSegment := false
    for _, ch := range s {
        if ch != ' ' {
            if !inSegment {
                count++
                inSegment = true
            }
        } else {
            inSegment = false
        }
    }
    return count
}