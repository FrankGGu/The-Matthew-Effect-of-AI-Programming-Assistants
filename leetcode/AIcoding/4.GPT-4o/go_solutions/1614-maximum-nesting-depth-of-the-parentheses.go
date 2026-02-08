func maxDepth(s string) int {
    maxDepth := 0
    currentDepth := 0

    for _, char := range s {
        if char == '(' {
            currentDepth++
            if currentDepth > maxDepth {
                maxDepth = currentDepth
            }
        } else if char == ')' {
            currentDepth--
        }
    }

    return maxDepth
}