import "sort"

func closeStrings(word1 string, word2 string) bool {
	if len(word1) != len(word2) {
		return false
	}

	freq1 := make([]int, 26)
	freq2 := make([]int, 26)

	for _, char := range word1 {
		freq1[char-'a']++
	}
	for _, char := range word2 {
		freq2[char-'a']++
	}

	for i := 0; i < 26; i++ {
		if (freq1[i] > 0 && freq2[i] == 0) || (freq1[i] == 0 && freq2[i] > 0) {
			return false
		}
	}

	sort.Ints(freq1)
	sort.Ints(freq2)

	for i := 0; i < 26; i++ {
		if freq1[i] != freq2[i] {
			return false
		}
	}

	return true
}