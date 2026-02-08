import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func solve(board [][]int) int {
	n := len(board)
	m := len(board[0])
	sum := 0
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			sum += board[i][j]
		}
	}

	rowMax := make([]int, n)
	colMax := make([]int, m)
	for i := 0; i < n; i++ {
		for j := 0; j < m; j++ {
			rowMax[i] = max(rowMax[i], board[i][j])
			colMax[j] = max(colMax[j], board[i][j])
		}
	}

	ans := math.MinInt64
	for r1 := 0; r1 < n; r1++ {
		for c1 := 0; c1 < m; c1++ {
			for r2 := 0; r2 < n; r2++ {
				for c2 := 0; c2 < m; c2++ {
					if r1 == r2 || c1 == c2 {
						continue
					}
					for r3 := 0; r3 < n; r3++ {
						for c3 := 0; c3 < m; c3++ {
							if r3 == r1 || r3 == r2 || c3 == c1 || c3 == c2 {
								continue
							}
							removed := rowMax[r1] + rowMax[r2] + rowMax[r3]
							removed = max(removed, colMax[c1]+colMax[c2]+colMax[c3])
							ans = max(ans, sum-removed)
						}
					}
				}
			}
		}
	}
	return ans
}

func maxValueSum(board [][]int) int {
	return solve(board)
}