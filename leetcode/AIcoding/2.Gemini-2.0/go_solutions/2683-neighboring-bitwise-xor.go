func doesValidArrayExist(derived []int) bool {
	n := len(derived)
	first := 0
	for i := 0; i < n; i++ {
		first ^= derived[i]
	}
	return first == 0
}