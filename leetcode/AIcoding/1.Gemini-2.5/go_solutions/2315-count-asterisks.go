func countAsterisks(s string) int {
    count := 0
    inPair := false // This flag tracks whether we are currently inside a pair of vertical bars

    for _, char := range s {
        if char == '|' {
            // Toggle the state when a vertical bar is encountered
            inPair = !inPair
        } else if char == '*' {
            // If the character is an asterisk and we are not inside a pair, increment the count
            if !inPair {
                count++
            }
        }
    }

    return count
}