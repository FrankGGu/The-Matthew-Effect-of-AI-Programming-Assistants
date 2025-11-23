package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func totalSteps(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}

	// dp[i] stores the number of steps nums[i] survives before being removed
	// If nums[i] is never removed, dp[i] will be 0.
	dp := make([]int, n)

	// stack stores indices of elements in decreasing order of their values.
	// Elements on the stack are potential "protectors" for elements to their right.
	stack := []int{}

	ans := 0

	for i := 0; i < n; i++ {
		currentSteps := 0
		for len(stack) > 0 {
			j := stack[len(stack)-1] // top of the stack

			if nums[j] <= nums[i] {
				if nums[j] < nums[i] {
					// nums[i] is strictly greater than nums[j].
					// nums[i] will cause nums[j] to be removed (or elements between j and i that are smaller than nums[j]).
					// nums[i] must "wait" for nums[j] to be removed.
					// The number of steps nums[i] survives is at least dp[j] + 1.
					currentSteps = max(currentSteps, dp[j]+1)
				} else { // nums[j] == nums[i]
					// nums[i] is equal to nums[j].
					// nums[i] does not remove nums[j], nor is it removed by nums[j].
					// nums[i] will be removed at the same step as nums[j] (by some element to their left).
					// So, nums[i] inherits the dp value of nums[j].
					currentSteps = dp[j]
					stack = stack[:len(stack)-1] // Pop j, as nums[i] effectively replaces nums[j]
					break                        // No need to check further elements on stack for nums[i]
				}
				stack = stack[:len(stack)-1] // Pop j
			} else { // nums[j] > nums[i]
				// nums[j] is greater than nums[i].
				// nums[j] is a "protector" for nums[i]. nums[i] will be removed by nums[j].
				// The removal happens after `currentSteps` steps (which accounts for elements between j and i that nums[i] removed).
				break // Found the left boundary for nums[i]
			}
		}

		// After the loop:
		// If stack is empty, it means nums[i] is the largest element encountered so far.
		// It won't be removed by any element to its left. So, dp[i] remains 0.
		// If stack is not empty, it means nums[stack.top()] > nums[i].
		// nums[i] will be removed by nums[stack.top()]. This happens after `currentSteps` steps.
		// So, dp[i] is `currentSteps`.
		dp[i] = currentSteps
		ans = max(ans, dp[i])
		stack = append(stack, i)
	}

	return ans
}