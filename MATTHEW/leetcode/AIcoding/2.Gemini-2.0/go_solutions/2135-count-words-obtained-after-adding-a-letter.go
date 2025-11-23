func wordMask(s string) int {
	mask := 0
	for _, c := range s {
		mask |= 1 << (c - 'a')
	}
	return mask
}

func wordSet(s string) map[int]bool {
	set := make(map[int]bool)
	for _, c := range s {
		set[int(c-'a')] = true
	}
	return set
}

func wordMask2(s string) map[int]bool {
	mask := make(map[int]bool)
	for _, c := range s {
		mask[int(c-'a')] = true
	}
	return mask
}

func wordMaskString(s string) string {
	arr := make([]bool, 26)
	for _, c := range s {
		arr[c-'a'] = true
	}

	result := ""
	for i, b := range arr {
		if b {
			result += string('a' + i)
		}
	}
	return result
}

func countWords(startWords []string, targetWords []string) int {
	startSet := make(map[string]bool)
	for _, word := range startWords {
		sortedWord := wordMaskString(word)
		startSet[sortedWord] = true
	}

	count := 0
	for _, target := range targetWords {
		sortedTarget := wordMaskString(target)
		for i := 0; i < len(sortedTarget); i++ {
			temp := sortedTarget[:i] + sortedTarget[i+1:]
			if startSet[temp] {
				count++
				break
			}
		}
	}

	return count
}