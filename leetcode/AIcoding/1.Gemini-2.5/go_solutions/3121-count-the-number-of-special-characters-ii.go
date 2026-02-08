import "math"

func countSpecialCharacters(s string) int {
	lastLowerIndex := make([]int, 26)
	firstUpperIndex := make([]int, 26)

	for i := 0; i < 26; i++ {
		lastLowerIndex[i] = -1
		firstUpperIndex[i] = math.MaxInt32
	}

	for i, r := range s {
		if r >= 'a' && r <= 'z' {
			lastLowerIndex[r-'a'] = i
		} else if r >= 'A' && r <= 'Z' {
			idx := r - 'A'
			if i < firstUpperIndex[idx] {
				firstUpperIndex[idx] = i
			}
		}
	}

	count := 0
	for i := 0; i < 26; i++ {
		if lastLowerIndex[i] != -1 && firstUpperIndex[i] != math.MaxInt32 {
			if lastLowerIndex[i] < firstUpperIndex[i] {
				count++
			}
		}
	}

	return count
}