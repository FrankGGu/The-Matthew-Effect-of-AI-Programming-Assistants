package main

func mostCompetitive(nums []int, k int) []int {
	n := len(nums)
	stack := make([]int, 0, k) 

	for i := 0; i < n; i++ {
		num := nums[i]

		// While the stack is not empty, the current number is smaller than the top of the stack,
		// AND we still have enough remaining elements to form a subsequence of length k
		// after popping the current top.
		// (len(stack) - 1) is the length of the stack after popping.
		// (n - i) is the number of elements available from the current position 'i' to the end of 'nums'.
		// The sum of these two must be at least 'k' to allow popping.
		for len(stack) > 0 && stack[len(stack)-1] > num && (len(stack)-1)+(n-i) >= k {
			stack = stack[:len(stack)-1] // Pop the top element
		}

		// If the stack has fewer than 'k' elements, append the current number.
		// This ensures we build up to length 'k' and also handles cases where elements were popped.
		if len(stack) < k {
			stack = append(stack, num)
		}
	}

	return stack
}