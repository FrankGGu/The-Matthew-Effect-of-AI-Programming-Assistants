func maxProduct(words []string) int {
	n := len(words)
	masks := make([]int, n)
	wordLengths := make([]int, n)

	for i := 0; i < n; i++ {
		word := words[i]
		length := len(word)
		mask := 0
		for _, char := range word {
			mask |= (1 << (char - 'a'))
		}
		masks[i] = mask
		wordLengths[i] = length
	}

	maxProd := 0

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if (masks[i] & masks[j]) == 0 {
				prod := wordLengths[i] * wordLengths[j]
				if prod > maxProd {
					maxProd = prod
				}
			}
		}
	}

	return maxProd
}