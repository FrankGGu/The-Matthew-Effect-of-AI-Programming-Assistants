func xorQueries(arr []int, queries [][]int) []int {
	n := len(arr)
	prefixXOR := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixXOR[i+1] = prefixXOR[i] ^ arr[i]
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		L, R := query[0], query[1]
		result[i] = prefixXOR[R+1] ^ prefixXOR[L]
	}

	return result
}