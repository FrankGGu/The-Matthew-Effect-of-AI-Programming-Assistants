func countAsterisks(s string) int {
    count := 0
    inBar := false

    for _, ch := range s {
        if ch == '|' {
            inBar = !inBar
        } else if ch == '*' && !inBar {
            count++
        }
    }

    return count
}