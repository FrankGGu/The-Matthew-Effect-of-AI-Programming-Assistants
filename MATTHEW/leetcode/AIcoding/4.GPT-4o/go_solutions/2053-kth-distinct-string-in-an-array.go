func kthDistinct(arr []string, k int) string {
    count := make(map[string]int)
    for _, str := range arr {
        count[str]++
    }

    distinctCount := 0
    for _, str := range arr {
        if count[str] == 1 {
            distinctCount++
            if distinctCount == k {
                return str
            }
        }
    }

    return ""
}