func chalkReplacer(chalk []int, k int) int {
	var sumChalk int64
	for _, c := range chalk {
		sumChalk += int64(c)
	}

	currentK := int64(k) % sumChalk

	for i, c := range chalk {
		if currentK < int64(c) {
			return i
		}
		currentK -= int64(c)
	}

	return -1 
}