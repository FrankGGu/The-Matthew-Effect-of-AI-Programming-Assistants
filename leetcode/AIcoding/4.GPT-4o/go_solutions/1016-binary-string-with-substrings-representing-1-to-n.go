func queryString(S string, N int) bool {
    for i := 1; i <= N; i++ {
        if !strings.Contains(S, strconv.FormatInt(int64(i), 2)) {
            return false
        }
    }
    return true
}