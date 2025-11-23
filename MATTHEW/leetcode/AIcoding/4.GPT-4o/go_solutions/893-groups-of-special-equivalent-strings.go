func numSpecialEquivGroups(A []string) int {
    groups := make(map[string]struct{})

    for _, s := range A {
        odd, even := make([]rune, 26), make([]rune, 26)
        for i, c := range s {
            if i%2 == 0 {
                even[c-'a']++
            } else {
                odd[c-'a']++
            }
        }
        key := string(odd) + string(even)
        groups[key] = struct{}{}
    }

    return len(groups)
}