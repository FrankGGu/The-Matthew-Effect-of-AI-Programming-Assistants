func matchReplacement(s string, sub string, mappings [][]byte) bool {
	m := make(map[byte]map[byte]bool)
	for _, mapping := range mappings {
		if _, ok := m[mapping[0]]; !ok {
			m[mapping[0]] = make(map[byte]bool)
		}
		m[mapping[0]][mapping[1]] = true
	}

	for i := 0; i <= len(s)-len(sub); i++ {
		match := true
		for j := 0; j < len(sub); j++ {
			if s[i+j] == sub[j] {
				continue
			}
			if _, ok := m[sub[j]]; ok {
				if _, ok2 := m[sub[j]][s[i+j]]; ok2 {
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