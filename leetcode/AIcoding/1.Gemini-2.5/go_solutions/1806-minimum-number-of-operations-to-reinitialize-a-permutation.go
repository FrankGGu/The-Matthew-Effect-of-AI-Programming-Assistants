func reinitializePermutation(n int) int {
	if n == 2 {
		return 1
	}

	initialPerm := make([]int, n)
	for i := 0; i < n; i++ {
		initialPerm[i] = i
	}

	currentPerm := make([]int, n)