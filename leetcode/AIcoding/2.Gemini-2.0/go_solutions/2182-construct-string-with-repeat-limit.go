import "sort"

func repeatLimitedString(s string, repeatLimit int) string {
	counts := make([]int, 26)
	for _, char := range s {
		counts[char-'a']++
	}

	result := []byte{}
	for i := 25; i >= 0; {
		if counts[i] == 0 {
			i--
			continue
		}

		repeat := min(counts[i], repeatLimit)
		for j := 0; j < repeat; j++ {
			result = append(result, byte('a'+i))
		}
		counts[i] -= repeat

		if counts[i] == 0 {
			i--
			continue
		}

		found := false
		for j := i - 1; j >= 0; j-- {
			if counts[j] > 0 {
				result = append(result, byte('a'+j))
				counts[j]--
				found = true
				break
			}
		}

		if !found {
			break
		}
	}

	return string(result)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}