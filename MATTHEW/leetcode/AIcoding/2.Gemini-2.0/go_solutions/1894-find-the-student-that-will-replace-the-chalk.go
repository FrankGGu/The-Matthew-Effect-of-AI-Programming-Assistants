func chalkReplacer(chalk []int, k int) int {
	sum := 0
	for _, c := range chalk {
		sum += c
	}
	k %= sum
	for i, c := range chalk {
		if k < c {
			return i
		}
		k -= c
	}
	return 0
}