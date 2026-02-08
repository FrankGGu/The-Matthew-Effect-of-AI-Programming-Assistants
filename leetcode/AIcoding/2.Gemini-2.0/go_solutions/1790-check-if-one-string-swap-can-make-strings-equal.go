func areAlmostEqual(s1 string, s2 string) bool {
	if s1 == s2 {
		return true
	}
	diff := 0
	idx1, idx2 := -1, -1
	for i := range s1 {
		if s1[i] != s2[i] {
			diff++
			if diff > 2 {
				return false
			}
			if idx1 == -1 {
				idx1 = i
			} else {
				idx2 = i
			}
		}
	}

	if diff == 2 {
		return s1[idx1] == s2[idx2] && s1[idx2] == s2[idx1]
	}

	return false
}