import "sort"

func kthLargestValue(matrix [][]int, k int) int {
	m, n := len(matrix), len(matrix[0])
	xor := make([][]int, m)
	for i := range xor {
		xor[i] = make([]int, n)
	}
	xor[0][0] = matrix[0][0]
	for i := 1; i < m; i++ {
		xor[i][0] = xor[i-1][0] ^ matrix[i][0]
	}
	for j := 1; j < n; j++ {
		xor[0][j] = xor[0][j-1] ^ matrix[0][j]
	}
	for i := 1; i < m; i++ {
		for j := 1; j < n; j++ {
			xor[i][j] = xor[i-1][j] ^ xor[i][j-1] ^ xor[i-1][j-1] ^ matrix[i][j]
		}
	}
	results := make([]int, 0)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			results = append(results, xor[i][j])
		}
	}
	sort.Ints(results)
	return results[len(results)-k]
}