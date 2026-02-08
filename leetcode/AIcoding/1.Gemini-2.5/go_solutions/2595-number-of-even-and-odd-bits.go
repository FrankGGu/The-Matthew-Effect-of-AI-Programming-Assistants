func evenOddBit(n int) []int {
	evenBitsCount := 0
	oddBitsCount := 0
	index := 0

	for n > 0 {
		if (n & 1) == 1 {
			if index%2 == 0 {
				evenBitsCount++
			} else {
				oddBitsCount++
			}
		}
		n >>= 1
		index++
	}

	return []int{evenBitsCount, oddBitsCount}
}