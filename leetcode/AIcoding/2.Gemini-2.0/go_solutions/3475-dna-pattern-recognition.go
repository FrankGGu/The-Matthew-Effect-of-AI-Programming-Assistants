func findRepeatedDnaSequences(s string) []string {
	n := len(s)
	if n < 10 {
		return []string{}
	}

	seen := make(map[string]bool)
	repeated := make(map[string]bool)
	result := []string{}

	for i := 0; i <= n-10; i++ {
		sub := s[i : i+10]
		if seen[sub] {
			if !repeated[sub] {
				result = append(result, sub)
				repeated[sub] = true
			}
		} else {
			seen[sub] = true
		}
	}

	return result
}