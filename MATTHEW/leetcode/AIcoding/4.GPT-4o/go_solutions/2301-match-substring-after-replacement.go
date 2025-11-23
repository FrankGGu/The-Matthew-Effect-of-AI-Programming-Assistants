func matchReplacement(s string, sub string, mappings [][]byte) bool {
    m := make(map[byte]map[byte]bool)
    for _, mapping := range mappings {
        if m[mapping[0]] == nil {
            m[mapping[0]] = make(map[byte]bool)
        }
        m[mapping[0]][mapping[1]] = true
    }

    subLen := len(sub)
    sLen := len(s)

    for i := 0; i <= sLen-subLen; i++ {
        match := true
        for j := 0; j < subLen; j++ {
            if s[i+j] != sub[j] && (m[sub[j]] == nil || !m[sub[j]][s[i+j]]) {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }

    return false
}