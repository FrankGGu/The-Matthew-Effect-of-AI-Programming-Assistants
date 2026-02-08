func alertNames(keyName []string, keyTime []string) []string {
    timeMap := make(map[string][]int)

    for i, name := range keyName {
        h, m := 0, 0
        fmt.Sscanf(keyTime[i], "%d:%d", &h, &m)
        minutes := h * 60 + m
        timeMap[name] = append(timeMap[name], minutes)
    }

    alertNamesSet := make(map[string]struct{})

    for name, times := range timeMap {
        sort.Ints(times)
        for i := 2; i < len(times); i++ {
            if times[i]-times[i-2] <= 60 {
                alertNamesSet[name] = struct{}{}
                break
            }
        }
    }

    result := make([]string, 0, len(alertNamesSet))
    for name := range alertNamesSet {
        result = append(result, name)
    }

    sort.Strings(result)
    return result
}