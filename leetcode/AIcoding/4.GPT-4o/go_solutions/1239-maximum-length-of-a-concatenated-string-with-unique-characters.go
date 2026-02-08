func maxLength(arr []string) int {
    maxLengthHelper := func(current string, index int) int {
        if index == len(arr) {
            if hasUniqueChars(current) {
                return len(current)
            }
            return 0
        }
        // Include the current string
        include := 0
        if hasUniqueChars(current + arr[index]) {
            include = maxLengthHelper(current + arr[index], index + 1)
        }
        // Exclude the current string
        exclude := maxLengthHelper(current, index + 1)
        return max(include, exclude)
    }

    return maxLengthHelper("", 0)
}

func hasUniqueChars(s string) bool {
    charSet := make(map[rune]bool)
    for _, c := range s {
        if charSet[c] {
            return false
        }
        charSet[c] = true
    }
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}