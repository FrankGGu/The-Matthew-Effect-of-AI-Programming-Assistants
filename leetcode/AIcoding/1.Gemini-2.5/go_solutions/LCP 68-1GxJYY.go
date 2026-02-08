func beautifulBouquet(flowers []int, k int) int {
	if k == 0 {
		return 0
	}

	n := len(flowers)
	if n == 0 {
		return 0
	}

	left := 0
	maxLen := 0
	freqMap := make