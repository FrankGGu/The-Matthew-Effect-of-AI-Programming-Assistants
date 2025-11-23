func xorQueries(arr []int, queries [][]int) []int {
	n := len(arr)
	prefixXor := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixXor[i+1] = prefixXor[i] ^ arr[i]
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		start := query[0]
		end := query[1]
		result[i] = prefixXor[end+1] ^ prefixXor[start]
	}

	return result
}