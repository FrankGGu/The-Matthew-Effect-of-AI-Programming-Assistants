func canConvertString(s string, t string, k int) bool {
    if len(s) != len(t) {
        return false
    }

    // counts[i] stores how many times a shift of 'i' has been encountered.
    // This helps determine the cycle for repeated shifts.
    // e.g.,