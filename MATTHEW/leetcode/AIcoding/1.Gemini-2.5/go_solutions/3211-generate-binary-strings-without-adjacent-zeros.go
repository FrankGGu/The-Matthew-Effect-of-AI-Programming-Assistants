func generateBinaryStrings(n int) []string {
    var results []string
    current := make([]byte, n)

    var backtrack func(index int)
    backtrack = func(index int) {
        if index == n {
            results = append(results, string(current))
            return
        }

        // Option 1: Place '1'
        current[index] = '1'
        backtrack(index + 1)

        // Option 2: Place '0'
        // Can place '0' if it's the first character OR if the previous character was '1'
        if index == 0 || current[index-1] == '1' {
            current[index] = '0'
            backtrack(index + 1)
        }
    }

    backtrack(0)
    return results
}