func areAlmostEqual(s1 string, s2 string) bool {
	if s1 == s2 {
		return true
	}

	diff := 0
	diffIndices := []int{}

	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diff++
			diffIndices = append(diffIndices, i)
		}
	}

	if diff == 2 {
		i, j := diffIndices[0], diffIndices[1]
		if s1[i] == s2[j] && s1[j] == s2[i] {
			return true
		}
	}

	return false
}