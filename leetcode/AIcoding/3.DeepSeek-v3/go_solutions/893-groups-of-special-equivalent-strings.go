func numSpecialEquivGroups(words []string) int {
    groups := make(map[string]bool)
    for _, word := range words {
        count := make([]int, 52)
        for i, c := range word {
            if i % 2 == 0 {
                count[c - 'a']++
            } else {
                count[c - 'a' + 26]++
            }
        }
        key := ""
        for _, v := range count {
            key += strconv.Itoa(v) + ","
        }
        groups[key] = true
    }
    return len(groups)
}