import "sort"

func fallingSquares(positions [][]int) []int {
	n := len(positions)
	heights := make([]int, n)
	for i := 0; i < n; i++ {
		left1, side1 := positions[i][0], positions[i][1]
		right1 := left1 + side1
		heights[i] = side1
		for j := 0; j < i; j++ {
			left2, side2 := positions[j][0], positions[j][1]
			right2 := left2 + side2
			if left1 < right2 && left2 < right1 {
				heights[i] = max(heights[i], heights[j]+side1)
			}
		}
	}

	ans := make([]int, n)
	ans[0] = heights[0]
	for i := 1; i < n; i++ {
		ans[i] = max(ans[i-1], heights[i])
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}