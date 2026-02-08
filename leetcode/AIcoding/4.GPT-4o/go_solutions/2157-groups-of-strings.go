func groupStrings(strings []string) int {
    if len(strings) == 0 {
        return 0
    }

    groups := make(map[string]bool)

    for _, str := range strings {
        key := make([]byte, len(str))
        for i := 0; i < len(str); i++ {
            key[i] = (str[i] - str[0] + 26) % 26 + 'a'
        }
        groups[string(key)] = true
    }

    return len(groups)
}