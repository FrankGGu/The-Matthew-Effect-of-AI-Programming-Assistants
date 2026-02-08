package main

func numSpecialEquivGroups(strs []string) int {
    groups := make(map[string]int)
    for _, s := range strs {
        key := ""
        for i, c := range s {
            if i%2 == 0 {
                key += string(c)
            }
        }
        for i, c := range s {
            if i%2 == 1 {
                key += string(c)
            }
        }
        sort.Slice([]rune(key), func(i, j int) bool { return key[i] < key[j] })
        groups[key]++
    }
    return len(groups)
}