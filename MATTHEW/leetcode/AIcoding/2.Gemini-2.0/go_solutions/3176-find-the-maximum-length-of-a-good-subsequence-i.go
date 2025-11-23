func findTheLongestBalancedSubsequence(s string) int {
    zeros := 0
    ones := 0
    for _, char := range s {
        if char == '0' {
            zeros++
        } else {
            ones++
        }
    }
    return 2 * min(zeros, ones)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}