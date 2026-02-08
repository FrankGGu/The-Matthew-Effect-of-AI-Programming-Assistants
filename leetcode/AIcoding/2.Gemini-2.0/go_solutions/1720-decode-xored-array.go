func decode(encoded []int, first int) []int {
	n := len(encoded) + 1
	decoded := make([]int, n)
	decoded[0] = first
	for i := 1; i < n; i++ {
		decoded[i] = decoded[i-1] ^ encoded[i-1]
	}
	return decoded
}