func checkOnesSegment(s string) bool {
    seenOne := false
    seenZeroAfterOne := false

    for _, char := range s {
        if char == '1' {
            if seenZeroAfterOne {
                return false
            }
            seenOne = true
        } else { // char == '0'
            if seenOne {
                seenZeroAfterOne = true
            }
        }
    }

    return true
}