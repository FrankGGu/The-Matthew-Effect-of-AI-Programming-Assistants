func minSteps(s string, t string) int {
	counts := [26]int{}

	for _, char := range s {
		counts[char-'a']++
	}

	for _, char := range t {
		counts[char-'a']--
	}

	steps := 0
	for i