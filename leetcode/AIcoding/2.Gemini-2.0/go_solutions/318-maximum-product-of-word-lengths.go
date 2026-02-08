func maxProduct(words []string) int {
	n := len(words)
	masks := make([]int, n)
	for i := 0; i < n; i++ {
		for _, char := range words[i] {
			masks[i] |= 1 << (char - 'a')
		}
	}

	maxProd := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if (masks[i] & masks[j]) == 0 {
				prod := len(words[i]) * len(words[j])
				if prod > maxProd {
					maxProd = prod
				}
			}
		}
	}

	return maxProd
}