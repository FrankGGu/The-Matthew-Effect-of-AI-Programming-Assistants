import "math"

func minWindow(s string, t string) string {
	if len(t) == 0 {
		return ""
	}

	tCount := make(map[byte]int)
	for i := 0; i < len(t); i++ {
		tCount[t[i]]++
	}

	windowCount := make(map[byte]int)

	requiredUniqueChars := len(tCount)
	matchedUniqueChars := 0

	left := 0
	minLen := math.MaxInt32
	startIdx := 0

	for right := 0; right < len(s); right++ {
		charR := s[right]
		windowCount[charR]++

		if _, ok := tCount[charR]; ok && windowCount[charR] == tCount[charR] {
			matchedUniqueChars++
		}

		for matchedUniqueChars == requiredUniqueChars {
			currentWindowLen := right - left + 1
			if currentWindowLen < minLen {
				minLen = currentWindowLen
				startIdx = left
			}

			charL := s[left]
			windowCount[charL]--

			if _, ok := tCount[charL]; ok && windowCount[charL] < tCount[charL] {
				matchedUniqueChars--
			}
			left++
		}
	}

	if minLen == math.MaxInt32 {
		return ""
	}

	return s[startIdx : startIdx+minLen]
}