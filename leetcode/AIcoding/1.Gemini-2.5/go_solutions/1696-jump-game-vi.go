package main

func maxResult(nums []int, k int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}

	// nums will be used as the dp array, where nums[i] stores the maximum score to reach index i.
	// The initial nums[i] values are already part of the score when landing on that index.

	// Deque to store indices, maintaining nums[q[j]] (which are dp values) in decreasing order.
	// q[0] will always be the index with the maximum score in the current valid window [i-k, i-1].
	q := []int{0} // Start with index 0, as nums[0] is the score for reaching index 0.

	for i := 1; i < n; i++ {
		// 1. Remove indices from the front of the deque that are out of the k-step jump window.
		// To reach index `i`, we must have jumped from an index `j` such that `i - k <= j < i`.
		// So, `q[0]` (the best previous index) must be within `[i-k, i-1]`.
		for len(q) > 0 && q[0] < i-k {
			q = q[1:]
		}

		// 2. The maximum score to jump from to reach `i` is `nums[q[0]]`.
		// Add the current `nums[i]` value to this max score to get the total score for reaching index `i`.
		nums[i] += nums[q[0]]

		// 3. Remove indices from the back of the deque whose scores are less than or equal to `nums[i]`.
		// This maintains the decreasing order property of scores in the deque,
		// ensuring `q[0]` always points to the maximum.
		for len(q) > 0 && nums[q[len(q)-1]] <= nums[i] {
			q = q[:len(q)-1]
		}

		// 4. Add the current index `i` to the back of the deque.
		q = append(q, i)
	}

	// The maximum score to reach the last index (n-1) is stored in nums[n-1].
	return nums[n-1]
}