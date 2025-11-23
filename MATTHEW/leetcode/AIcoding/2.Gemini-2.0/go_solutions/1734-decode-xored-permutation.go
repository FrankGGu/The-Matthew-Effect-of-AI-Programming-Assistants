func decode(encoded []int, first int) []int {
	n := len(encoded) + 1
	perm := make([]int, n)
	perm[0] = first
	for i := 0; i < n-1; i++ {
		perm[i+1] = perm[i] ^ encoded[i]
	}
	return perm
}