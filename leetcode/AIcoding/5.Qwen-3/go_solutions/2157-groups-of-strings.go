package main

func groupStrings(strings []string) [][]string {
    groups := make(map[string][]string)

    for _, s := range strings {
        key := ""
        for i := 1; i < len(s); i++ {
            diff := (int(s[i]) - int(s[i-1]) + 26) % 26
            key += strconv.Itoa(diff) + ","
        }
        groups[key] = append(groups[key], s)
    }

    result := make([][]string, 0, len(groups))
    for _, v := range groups {
        result = append(result, v)
    }

    return result
}