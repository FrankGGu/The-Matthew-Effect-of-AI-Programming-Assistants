func minSteps(s string, t string) int {
	freqS := [26]int{}
	freqT := [26]int{}

	for _, char := range s {
		freqS[char-'a']++
	}

	for _, char := range t {
		freqT[char-'a']++
	}

	steps := 0
	for i := 0; i < 26; i++ {
		if freqS[i] > freqT[i] {
			steps += freqS[i] - freqT[i]
		}
	}

	return steps
}