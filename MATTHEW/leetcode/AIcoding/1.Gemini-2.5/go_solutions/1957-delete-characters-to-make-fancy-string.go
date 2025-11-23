func makeFancyString(s string) string {
	if len(s) < 3 {
		return s
	}

	result := make([]byte, 0, len(s))

	for i := 0; i < len(s); i++ {
		char := s[i]
		if len(result) >= 2 && result[len(result)-1] == char && result[len(result)-2] == char {
			continue
		}
		result = append(result, char)
	}

	return string(result)
}