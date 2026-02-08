func maxFreq(s string, maxLetters int, minSize int, maxSize int) int {
	count := make(map[string]int)
	maxCount := 0
	for i := 0; i <= len(s)-minSize; i++ {
		sub := s[i : i+minSize]
		letters := make(map[rune]bool)
		for _, r := range sub {
			letters[r] = true
		}
		if len(letters) <= maxLetters {
			count[sub]++
			if count[sub] > maxCount {
				maxCount = count[sub]
			}
		}
	}
	return maxCount
}