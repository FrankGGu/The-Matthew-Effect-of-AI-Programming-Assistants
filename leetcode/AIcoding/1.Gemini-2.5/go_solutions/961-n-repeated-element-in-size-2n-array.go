func repeatedNElement(A []int) int {
	seen := make(map[int]bool)
	for _, num := range A {
		if seen[num] {
			return num
		}
		seen[num] = true
	}
	return -1
}