func oddEvenJumps(A []int) int {
	n := len(A)
	if n == 1 {
		return 1
	}

	odd := make([]bool, n)
	even := make([]bool, n)
	odd[n-1], even[n-1] = true, true
	oddCount, evenCount := 1, 0

	type pair struct {
		value int
		index int
	}

	// Helper function to calculate the next jump
	calculateNextJump := func(isOdd bool) {
		var stack []pair
		for i := n - 1; i >= 0; i-- {
			for len(stack) > 0 && (isOdd && stack[len(stack)-1].value < A[i] || !isOdd && stack[len(stack)-1].value > A[i]) {
				stack = stack[:len(stack)-1]
			}
			if len(stack) > 0 {
				if isOdd {
					odd[i] = even[stack[len(stack)-1].index]
				} else {
					even[i] = odd[stack[len(stack)-1].index]
				}
			}
			stack = append(stack, pair{A[i], i})
		}
	}

	calculateNextJump(true)
	calculateNextJump(false)

	for i := 0; i < n; i++ {
		if odd[i] {
			oddCount++
		}
	}

	return oddCount
}