func maxSlidingWindow(nums []int, k int) []int {
	if len(nums) == 0 || k <= 0 {
		return []int{}
	}

	n := len(nums)
	if k > n {
		k = n
	}

	result := make([]int, n-k+1)
	deque := []int{}

	for i := 0; i < n; i++ {
		for len(deque) > 0 && nums[deque[len(deque)-1]] <= nums[i] {
			deque = deque[:len(deque)-1]
		}

		deque = append(deque, i)

		if deque[0] <= i-k {
			deque = deque[1:]
		}

		if i >= k-1 {
			result[i-k+1] = nums[deque[0]]
		}
	}

	return result
}