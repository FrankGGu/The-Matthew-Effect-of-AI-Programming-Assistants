package main

func numSpecialEquivGroups(words []string) int {
    seen := make(map[string]bool)
    for _, word := range words {
        even := []byte{}
        odd := []byte{}
        for i, c := range word {
            if i%2 == 0 {
                even = append(even, byte(c))
            } else {
                odd = append(odd, byte(c))
            }
        }
        sort.Slice(even, func(i, j int) bool { return even[i] < even[j] })
        sort.Slice(odd, func(i, j int) bool { return odd[i] < odd[j] })
        key := string(even) + string(odd)
        seen[key] = true
    }
    return len(seen)
}