func findTheNthValue(n int, k int) int {
	k %= 3
	if k == 0 {
		return n
	} else if k == 1 {
		return (n * 2)
	} else {
		if n%2 == 0 {
			return (n / 2)
		} else {
			return (n*(-1) - 1) / 2
		}
	}
}