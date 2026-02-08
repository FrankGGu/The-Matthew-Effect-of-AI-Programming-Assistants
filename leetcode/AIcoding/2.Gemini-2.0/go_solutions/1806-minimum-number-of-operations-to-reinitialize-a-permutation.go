func reinitializePermutation(n int) int {
	arr := make([]int, n)
	perm := make([]int, n)
	target := make([]int, n)
	for i := 0; i < n; i++ {
		arr[i] = i
		target[i] = i
	}

	ops := 0
	for {
		nextPerm := make([]int, n)
		for i := 0; i < n; i++ {
			if i%2 == 0 {
				nextPerm[i] = arr[i/2]
			} else {
				nextPerm[i] = arr[n/2+(i-1)/2]
			}
		}
		arr = nextPerm
		ops++

		match := true
		for i := 0; i < n; i++ {
			if arr[i] != target[i] {
				match = false
				break
			}
		}

		if match {
			return ops
		}
	}
}