func distinctNames(ideas []string) int64 {
    groups := make([]map[byte]bool, 26)
    for i := range groups {
        groups[i] = make(map[byte]bool)
    }

    for _, idea := range ideas {
        groups[idea[0]-'a'][idea[1]] = true
    }

    var ans int64
    for i := 0; i < 26; i++ {
        for j := i + 1; j < 26; j++ {
            common := 0
            for char := range groups[i] {
                if groups[j][char] {
                    common++
                }
            }
            ans += int64(len(groups[i]) - common) * int64(len(groups[j]) - common)
        }
    }

    return ans * 2
}