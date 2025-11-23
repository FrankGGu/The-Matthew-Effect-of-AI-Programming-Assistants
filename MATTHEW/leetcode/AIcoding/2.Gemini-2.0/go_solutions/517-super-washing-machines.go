func findMinMoves(machines []int) int {
	sum := 0
	for _, m := range machines {
		sum += m
	}
	n := len(machines)
	if sum%n != 0 {
		return -1
	}
	avg := sum / n
	ans := 0
	cur := 0
	for _, m := range machines {
		cur += m - avg
		ans = max(ans, max(abs(cur), m-avg))
	}
	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}