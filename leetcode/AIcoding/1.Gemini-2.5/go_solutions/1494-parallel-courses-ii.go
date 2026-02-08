func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

const infinity = 1e9 // A sufficiently large number for infinity

func minNumberOfSemesters(n int, relations [][]int,