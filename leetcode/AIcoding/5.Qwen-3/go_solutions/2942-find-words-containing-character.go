package main

func removeOccurrences(s string, part string) string {
	for len(s) >= len(part) && s != "" {
		idx := -1
		for i := 0; i <= len(s)-len(part); i++ {
			if s[i:i+len(part)] == part {
				idx = i
				break
			}
		}
		if idx == -1 {
			break
		}
		s = s[:idx] + s[idx+len(part):]
	}
	return s
}