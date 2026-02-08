func smallestNumberWithAllSetBits(k int) int64 {
	if k == 0 {
		return 0
	}
	return (int64(1) << k) - 1
}