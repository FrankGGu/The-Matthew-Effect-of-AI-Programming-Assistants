import "sort"

func closeStrings(word1 string, word2 string) bool {
	if len(word1) != len(word2) {
		return false
	}

	freq1 := make(map[rune]int)
	freq2 := make(map[rune]int)

	for _, char := range word1 {
		freq1[char]++
	}
	for _, char := range word2 {
		freq2[char]++
	}

	keys1 := make([]rune, 0, len(freq1))
	for k := range freq1 {
		keys1 = append(keys1, k)
	}
	keys2 := make([]rune, 0, len(freq2))
	for k := range freq2 {
		keys2 = append(keys2, k)
	}

	sort.Slice(keys1, func(i, j int) bool {
		return keys1[i] < keys1[j]
	})
	sort.Slice(keys2, func(i, j int) bool {
		return keys2[i] < keys2[j]
	})

	if len(keys1) != len(keys2) {
		return false
	}

	for i := 0; i < len(keys1); i++ {
		if keys1[i] != keys2[i] {
			return false
		}
	}

	vals1 := make([]int, 0, len(freq1))
	for _, v := range freq1 {
		vals1 = append(vals1, v)
	}
	vals2 := make([]int, 0, len(freq2))
	for _, v := range freq2 {
		vals2 = append(vals2, v)
	}

	sort.Ints(vals1)
	sort.Ints(vals2)

	for i := 0; i < len(vals1); i++ {
		if vals1[i] != vals2[i] {
			return false
		}
	}

	return true
}