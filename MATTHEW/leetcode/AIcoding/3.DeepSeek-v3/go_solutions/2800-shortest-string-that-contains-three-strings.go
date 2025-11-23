func minimumString(a string, b string, c string) string {
    candidates := []string{}
    permutations := [][]string{
        {a, b, c},
        {a, c, b},
        {b, a, c},
        {b, c, a},
        {c, a, b},
        {c, b, a},
    }

    for _, p := range permutations {
        s1 := merge(p[0], p[1])
        s2 := merge(s1, p[2])
        candidates = append(candidates, s2)
    }

    minStr := candidates[0]
    for _, s := range candidates {
        if len(s) < len(minStr) || (len(s) == len(minStr) && s < minStr) {
            minStr = s
        }
    }
    return minStr
}

func merge(a, b string) string {
    if strings.Contains(a, b) {
        return a
    }
    if strings.Contains(b, a) {
        return b
    }
    maxOverlap := 0
    minLen := min(len(a), len(b))
    for i := 1; i <= minLen; i++ {
        if a[len(a)-i:] == b[:i] {
            maxOverlap = i
        }
    }
    return a + b[maxOverlap:]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}