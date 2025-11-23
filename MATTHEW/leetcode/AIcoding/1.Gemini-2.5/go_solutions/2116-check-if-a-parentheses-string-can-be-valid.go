func canBeValid(s string, locked string) bool {
    n := len(s)

    // A valid parentheses string must have an even length.
    // The problem statement guarantees n is even, but this is a good sanity check.
    if n%2 != 0 {
        return false
    }

    // Pass