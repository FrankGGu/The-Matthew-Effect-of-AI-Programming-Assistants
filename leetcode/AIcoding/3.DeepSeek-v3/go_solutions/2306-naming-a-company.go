func distinctNames(ideas []string) int64 {
    initialGroups := make(map[byte]map[string]bool)
    for _, idea := range ideas {
        initial := idea[0]
        suffix := idea[1:]
        if initialGroups[initial] == nil {
            initialGroups[initial] = make(map[string]bool)
        }
        initialGroups[initial][suffix] = true
    }

    var result int64 = 0
    initials := make([]byte, 0, len(initialGroups))
    for initial := range initialGroups {
        initials = append(initials, initial)
    }

    for i := 0; i < len(initials); i++ {
        for j := i + 1; j < len(initials); j++ {
            a, b := initials[i], initials[j]
            setA, setB := initialGroups[a], initialGroups[b]
            common := 0
            for suffix := range setA {
                if setB[suffix] {
                    common++
                }
            }
            result += int64(2 * (len(setA) - common) * (len(setB) - common))
        }
    }
    return result
}