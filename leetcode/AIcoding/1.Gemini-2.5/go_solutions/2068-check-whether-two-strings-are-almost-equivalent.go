import "math"

func checkAlmostEquivalent(word1 string, word2 string) bool {
	freq1 := [26]int{}
	freq2 := [26]int{}

	for _, char := range word1 {
		freq1[char-'a']++
	}

	for _, char := range word2 {
		freq2[char-'a']++
	}

	for i := 0; i < 26; i++ {
		diff := int(math.Abs(float64(freq1[i] - freq2[i])))
		if diff > 3 {
			return false
		}
	}

	return true
}