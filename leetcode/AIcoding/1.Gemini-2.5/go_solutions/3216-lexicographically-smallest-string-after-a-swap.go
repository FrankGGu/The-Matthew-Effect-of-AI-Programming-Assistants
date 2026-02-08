func findLexSmallestString(s string) string {
    n := len(s)
    if n <= 1 {
        return s
    }

    chars := []byte(s)

    for i := 0; i < n; i++ {
        minChar := chars[i]
        minCharIdx := i

        // Find the smallest character in the suffix s[i+1...n-1]
        // If there are multiple occurrences of the smallest character,
        // pick the rightmost one to ensure the resulting string is as small as possible.
        for j := i + 1; j < n; j++ {
            if chars[j] <= minChar {
                minChar = chars[j]
                minCharIdx = j
            }
        }

        // If a character smaller than chars[i] was found (or chars[i] itself but further right),
        // and it's strictly smaller than chars[i], perform the swap.
        // This is the optimal single swap to make the string lexicographically smallest
        // at the current position i.
        if minChar < chars[i] {
            chars[i], chars[minCharIdx] = chars[minCharIdx], chars[i]
            return string(chars)
        }
    }

    // If no swap could make the string lexicographically smaller,
    // return the original string.
    return s
}