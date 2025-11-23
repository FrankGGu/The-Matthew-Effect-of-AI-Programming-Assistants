func countAsterisks(s string) int {
    inPair := false
    count := 0
    for _, c := range s {
        if c == '|' {
            inPair = !inPair
        } else if c == '*' && !inPair {
            count++
        }
    }
    return count
}