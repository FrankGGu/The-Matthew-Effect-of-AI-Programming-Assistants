func countBinarySubstrings(s string) int {
    groups := []int{}
    count := 1

    for i := 1; i < len(s); i++ {
        if s[i] == s[i-1] {
            count++
        } else {
            groups = append(groups, count)
            count = 1
        }
    }
    groups = append(groups, count)

    result := 0
    for i := 1; i < len(groups); i++ {
        result += min(groups[i-1], groups[i])
    }

    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}