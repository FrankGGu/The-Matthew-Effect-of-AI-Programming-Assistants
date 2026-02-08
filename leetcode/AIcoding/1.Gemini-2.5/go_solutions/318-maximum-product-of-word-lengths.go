func maxProduct(words []string) int {
	n := len(words)
	masks := make([]int, n)
	lengths := make([]int, n)

	for i, word := range words {
		mask := 0
		for _, char := range word {
			mask |= (1 << (char - 'a'))
		}
		masks[i] = mask
		lengths[i] = len(word)
	}

	maxProd := 0

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if (masks[i] & masks[j]) == 0 {
				prod := lengths[i] * lengths[j]
				if prod > maxProd {
					maxProd = prod
				}
			}
		}
	}

	return maxProd
}