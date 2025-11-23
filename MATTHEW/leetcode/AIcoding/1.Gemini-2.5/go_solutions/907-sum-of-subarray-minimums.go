package main

func sumSubarrayMins(arr []int) int {
	n := len(arr)
	ple := make([]int, n)
	nle := make([]int, n)

	stack := []int{}

	for i := 0; i < n; i++ {
		for len(stack) > 0 && arr[stack[len(stack)-1]] >= arr[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			ple[i] = -1
		} else {
			ple[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	stack = []int{}

	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && arr[stack[len(stack)-1]] > arr[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			nle[i] = n
		} else {
			nle[i] = stack[len(stack)-1]
		}
		stack = append(stack, i)
	}

	ans := 0
	mod := 1000000007

	for i := 0; i < n; i++ {
		leftCount := i - ple[i]
		rightCount := nle[i] - i

		contribution := (arr[i] * leftCount) % mod
		contribution = (contribution * rightCount) % mod

		ans = (ans + contribution) % mod
	}

	return ans
}