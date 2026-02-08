func findKthNumber(n int, k int) int {
	curr := 1
	k--
	for k > 0 {
		steps := getSteps(n, curr, curr+1)
		if steps <= k {
			curr++
			k -= steps
		} else {
			curr *= 10
			k--
		}
	}
	return curr
}

func getSteps(n int, n1 int, n2 int) int {
	steps := 0
	for n1 <= n {
		steps += min(n+1, n2) - n1
		n1 *= 10
		n2 *= 10
	}
	return steps
}

func min(a int, b int) int {
	if a < b {
		return a
	}
	return b
}