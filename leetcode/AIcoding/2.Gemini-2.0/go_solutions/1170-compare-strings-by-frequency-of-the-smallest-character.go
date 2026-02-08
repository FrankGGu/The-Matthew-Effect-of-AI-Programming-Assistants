import "sort"

func numSmallerByFrequency(queries []string, words []string) []int {
	freq := make([]int, len(words))
	for i, word := range words {
		freq[i] = f(word)
	}
	sort.Ints(freq)

	result := make([]int, len(queries))
	for i, query := range queries {
		qf := f(query)
		count := 0
		for _, wf := range freq {
			if wf > qf {
				count++
			}
		}
		result[i] = count
	}
	return result
}

func f(s string) int {
	minChar := 'z' + 1
	for _, char := range s {
		if char < minChar {
			minChar = char
		}
	}

	count := 0
	for _, char := range s {
		if char == minChar {
			count++
		}
	}
	return count
}