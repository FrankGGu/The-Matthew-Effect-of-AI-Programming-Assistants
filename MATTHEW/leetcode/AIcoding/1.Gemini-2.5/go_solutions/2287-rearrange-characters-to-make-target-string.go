import "math"

func rearrangeCharacters(s string, target string) int {
	sFreq := make(map[rune]int)
	for _, char := range s {
		sFreq[char]++
	}

	targetFreq := make(map[rune]int)
	for _, char := range target {
		targetFreq[char]++
	}

	ans := math.MaxInt32

	for char, count := range targetFreq {
		availableCount := sFreq[char] // Defaults to 0 if char not in sFreq

		if count == 0 { // Should not happen for valid target, but good to handle
			continue
		}

		possibleTimes := availableCount / count
		if possibleTimes < ans {
			ans = possibleTimes
		}
	}

	if ans == math.MaxInt32 { // This means targetFreq was empty, which implies target was empty.
	                          // An empty target can be formed infinite times, but problem constraints
	                          // usually mean target is non-empty. If target is empty, 0 is a reasonable answer.
		return 0 // If target is empty, or if no chars from target are found, but target is non-empty, this could be 0.
	}

	return ans
}