package main

func maximumSumOfHeights(maxHeights []int) int64 {
	n := len(maxHeights)
	left := make([]int64, n)
	right := make([]int64, n)

	stack := []int{}
	for i := 0; i < n; i++ {
		for len(stack) > 0 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
			stack = stack[:len(stack)-1]
		}

		var prevIdx int
		var prevSum int64
		if len(stack) == 0 {
			prevIdx = -1
			prevSum = 0
		} else {
			prevIdx = stack[len(stack)-1]
			prevSum = left[prevIdx]
		}

		left[i] = int64(i-prevIdx) * int64(maxHeights[i]) + prevSum
		stack = append(stack, i)
	}

	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
			stack = stack[:len(stack)-1]
		}

		var nextIdx int
		var nextSum int64
		if len(stack) == 0 {
			nextIdx = n
			nextSum = 0
		} else {
			nextIdx = stack[len(stack)-1]
			nextSum = right[nextIdx]
		}

		right[i] = int64(nextIdx-i) * int64(maxHeights[i]) + nextSum
		stack = append(stack, i)
	}

	var maxSum int64 = 0
	for i := 0; i < n; i++ {
		currentSum := left[i] + right[i] - int64(maxHeights[i])
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}