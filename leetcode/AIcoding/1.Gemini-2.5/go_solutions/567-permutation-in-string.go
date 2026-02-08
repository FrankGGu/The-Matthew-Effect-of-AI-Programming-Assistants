func checkInclusion(s1 string, s2 string) bool {
	len1 := len(s1)
	len2 := len(s2)

	if len1 > len2 {
		return false
	}

	s1Counts := [26]int{}
	windowCounts := [26]int{}

	for i := 0; i < len1; i++ {
		s1Counts[s1[i]-'a']++
		windowCounts[s2[i]-'a']++
	}

	if s1Counts == windowCounts {
		return true
	}

	for i := len1; i < len2; i++ {
		windowCounts[s2[i]-'a']++
		windowCounts[s2[i-len1]-'a']--
		if s1Counts == windowCounts {
			return true
		}
	}

	return false
}