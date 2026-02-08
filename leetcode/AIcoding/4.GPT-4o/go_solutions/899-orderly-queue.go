func orderlyQueue(s string, k int) string {
    if k == 1 {
        minStr := s
        for i := 0; i < len(s); i++ {
            s = s[1:] + s[:1]
            if s < minStr {
                minStr = s
            }
        }
        return minStr
    }

    sorted := []rune(s)
    sort.Slice(sorted, func(i, j int) bool {
        return sorted[i] < sorted[j]
    })
    return string(sorted)
}