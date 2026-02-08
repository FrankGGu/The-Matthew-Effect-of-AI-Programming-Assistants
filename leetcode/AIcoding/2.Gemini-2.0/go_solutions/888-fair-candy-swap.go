func fairCandySwap(aliceSizes []int, bobSizes []int) []int {
	sumA := 0
	sumB := 0
	setB := make(map[int]bool)

	for _, a := range aliceSizes {
		sumA += a
	}

	for _, b := range bobSizes {
		sumB += b
		setB[b] = true
	}

	diff := (sumB - sumA) / 2

	for _, a := range aliceSizes {
		if _, ok := setB[a+diff]; ok {
			return []int{a, a + diff}
		}
	}

	return []int{}
}