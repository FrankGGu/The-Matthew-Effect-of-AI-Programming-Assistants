func groupStrings(strings []string) [][]string {
    groups := make(map[string][]string)

    for _, s := range strings {
        key := getKey(s)
        groups[key] = append(groups[key], s)
    }

    result := make([][]string, 0, len(groups))
    for _, group := range groups {
        result = append(result, group)
    }

    return result
}

func getKey(s string) string {
    if len(s) == 0 {
        return ""
    }

    key := make([]byte, len(s))
    shift := s[0] - 'a'
    for i := 0; i < len(s); i++ {
        original := s[i] - 'a'
        shifted := (original - shift + 26) % 26
        key[i] = 'a' + shifted
    }

    return string(key)
}