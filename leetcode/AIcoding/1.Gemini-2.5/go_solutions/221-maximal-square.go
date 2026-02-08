import "fmt"

func maximalSquare(matrix [][]byte) int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return 0
	}

	m := len(matrix)
	n := len(matrix[0])

	// dp[i][j