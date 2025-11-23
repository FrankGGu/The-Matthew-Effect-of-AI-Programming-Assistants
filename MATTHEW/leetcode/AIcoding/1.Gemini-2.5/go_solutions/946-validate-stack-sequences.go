func validateStackSequences(pushed []int, popped []int) bool {
	stack := []int{} // Simulate a stack using a slice
	j := 0           // Pointer for the popped array

	for _, x := range pushed {
		stack = append(stack, x) // Push the current element from pushed onto the stack

		// While the stack is not empty, and we haven't exhausted the popped array,
		// and the top of the stack matches the current element in popped,
		// simulate a pop operation.
		for len(stack) > 0 && j < len(popped) && stack[len(stack)-1] == popped[j] {
			stack = stack[:len(stack)-1] // Pop from the stack
			j++                          // Move to the next element in popped
		}
	}

	// If all elements in popped were successfully matched and popped from the stack,
	// then j should be equal to the length of the popped array.
	return