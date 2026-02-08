import (
	"sort"
)

func kthLargestValue(matrix [][]int, k int) int {
	m := len(matrix)
	n := len(matrix[0])

	// dp[i][j] will store the XOR sum of the submatrix from (0,0) to (i-1,j-1).
	// This means the dp table will be (m+1) x (n+1) to handle base cases easily.
	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
	}

	// Collect all XOR coordinate values
	var values []int

	// Iterate from i=1 to m and j=1 to n to fill the dp table
	// and collect the XOR coordinate values.
	// Note that matrix indices are (i-1, j-1) for dp table indices (i,j).
	for i := 1; i <= m; i++ {
		for j := 1; j <= n; j++ {
			// The XOR sum of the current submatrix is calculated using the
			// standard 2D prefix XOR sum formula.
			// dp[i][j] = matrix[i-1][j-1] ^ dp[i-1][j] ^ dp[i][j-1] ^ dp[i-1][j-1]
			dp[i][j] = matrix[i-1][j-1] ^ dp[i-1][j] ^ dp[i][j-1] ^ dp[i-1][j-1]
			values = append(values, dp[i][j])
		}
	}

	// Sort the collected values in descending order.
	sort.Slice(values, func(a, b int) bool {
		return values[a] > values[b]
	})

	// The k-th largest value is at index k-1 (since slices are 0-indexed).
	return values[k-1]
}