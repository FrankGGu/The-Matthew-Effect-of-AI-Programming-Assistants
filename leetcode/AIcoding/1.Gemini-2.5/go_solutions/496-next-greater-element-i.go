func nextGreaterElement(nums1 []int, nums2 []int) []int {
	numToNGE := make(map[int]int)
	stack := []int{} // Monotonic stack to store elements from nums2

	// Step 1: Process nums2 to find next greater elements for each number
	for _, num := range nums2 {
		// While stack is not empty and current num is greater than the top of the stack
		for len(stack) > 0 && num > stack[len(stack)-1] {
			// Pop the element from stack, its next greater element is 'num'
			popped := stack[len(stack)-1]
			stack = stack[:len(stack)-1]
			numToNGE[popped] = num
		}
		// Push current num onto the stack
		stack = append(stack, num)
	}

	// Step 2: Populate the result array for nums1 based on the map
	result := make([]int, len(nums1))
	for i, num := range nums1 {
		// Check if the next greater element exists in the map
		if nge, found := numToNGE[num]; found {
			result[i] = nge
		} else {
			// If not found, it means there is no next greater element in nums2
			result[i] = -1
		}
	}

	return result
}