func checkStrings(s1 string, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }
    n := len(s1)
    even1 := make([]rune, 0)
    odd1 := make([]rune, 0)
    even2 := make([]rune, 0)
    odd2 := make([]rune, 0)

    for i := 0; i < n; i++ {
        if i % 2 == 0 {
            even1 = append(even1, rune(s1[i]))
            even2 = append(even2, rune(s2[i]))
        } else {
            odd1 = append(odd1, rune(s1[i]))
            odd2 = append(odd2, rune(s2[i]))
        }
    }

    sort.Slice(even1, func(i, j int) bool { return even1[i] < even1[j] })
    sort.Slice(odd1, func(i, j int) bool { return odd1[i] < odd1[j] })
    sort.Slice(even2, func(i, j int) bool { return even2[i] < even2[j] })
    sort.Slice(odd2, func(i, j int) bool { return odd2[i] < odd2[j] })

    return string(even1) == string(even2) && string(odd1) == string(odd2)
}