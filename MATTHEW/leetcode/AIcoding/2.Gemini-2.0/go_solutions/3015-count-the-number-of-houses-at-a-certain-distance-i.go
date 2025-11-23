func countOfPairs(n int, x int, y int) []int {
	ans := make([]int, n)
	for i := 1; i <= n; i++ {
		for j := i + 1; j <= n; j++ {
			d1 := abs(i - j)
			d2 := abs(i - x) + abs(y - j) + 1
			d3 := abs(i - y) + abs(x - j) + 1
			d := min(d1, min(d2, d3))
			ans[d-1] += 2
		}
	}
	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}