func shiftingLetters(s string, shifts []int) string {
    n := len(s)
    runes := []rune(s)

    currentShiftSum := 0

    // Iterate from right to left to calculate the cumulative shift for each character
    // and apply it immediately.
    for i := n