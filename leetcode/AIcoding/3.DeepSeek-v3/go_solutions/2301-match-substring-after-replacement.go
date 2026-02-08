func matchReplacement(s string, sub string, mappings [][]byte) bool {
    m := len(sub)
    n := len(s)
    if m > n {
        return false
    }

    // Create a map for allowed replacements
    replaceMap := make(map[byte]map[byte]bool)
    for _, mapping := range mappings {
        old := mapping[0]
        new := mapping[1]
        if _, ok := replaceMap[old]; !ok {
            replaceMap[old] = make(map[byte]bool)
        }
        replaceMap[old][new] = true
    }

    for i := 0; i <= n - m; i++ {
        match := true
        for j := 0; j < m; j++ {
            sc := s[i+j]
            subc := sub[j]
            if sc == subc {
                continue
            }
            if replacements, ok := replaceMap[subc]; ok {
                if _, ok := replacements[sc]; ok {
                    continue
                }
            }
            match = false
            break
        }
        if match {
            return true
        }
    }
    return false
}