func print(n int) int {
	if n == 1 {
		return 1
	}
	maxA := n
	for b := 1; b < n-2; b++ {
		a := print(b)
		ctrlV := n - b - 1
		maxA = max(maxA, a*ctrlV)
	}
	return maxA
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}