func maximumSumOfHeights(maxHeights []int) int64 {
	n := len(maxHeights)
	left := make([]int, n)
	right := make([]int, n)
	stack := []int{}

	for i := 0; i < n; i++ {
		for len(stack) > 0 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			left[i] = (i + 1) * maxHeights[i]
		} else {
			left[i] = left[stack[len(stack)-1]] + (i-stack[len(stack)-1])*maxHeights[i]
		}
		stack = append(stack, i)
	}

	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			right[i] = (n - i) * maxHeights[i]
		} else {
			right[i] = right[stack[len(stack)-1]] + (stack[len(stack)-1]-i)*maxHeights[i]
		}
		stack = append(stack, i)
	}

	ans := int64(0)
	for i := 0; i < n; i++ {
		curr := int64(left[i] + right[i] - maxHeights[i])
		if curr > ans {
			ans = curr
		}
	}

	return ans
}