func findMinimumOperations(s1 string, s2 string, s3 string) int {
    minLen := min(len(s1), min(len(s2), len(s3)))
    common := 0
    for i := 0; i < minLen; i++ {
        if s1[i] == s2[i] && s2[i] == s3[i] {
            common++
        } else {
            break
        }
    }
    if common == 0 {
        return -1
    }
    return (len(s1) - common) + (len(s2) - common) + (len(s3) - common)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}