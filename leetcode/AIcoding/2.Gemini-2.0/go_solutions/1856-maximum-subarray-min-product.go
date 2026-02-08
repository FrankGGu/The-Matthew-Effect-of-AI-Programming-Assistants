func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func maxSubarrayMinProduct(nums []int) int {
	n := len(nums)
	left := make([]int, n)
	right := make([]int, n)
	stack := []int{}

	for i := 0; i < n; i++ {
		for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			left[i] = 0
		} else {
			left[i] = stack[len(stack)-1] + 1
		}
		stack = append(stack, i)
	}

	stack = []int{}
	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && nums[stack[len(stack)-1]] > nums[i] {
			stack = stack[:len(stack)-1]
		}
		if len(stack) == 0 {
			right[i] = n - 1
		} else {
			right[i] = stack[len(stack)-1] - 1
		}
		stack = append(stack, i)
	}

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	ans := 0
	for i := 0; i < n; i++ {
		sum := prefixSum[right[i]+1] - prefixSum[left[i]]
		ans = max(ans, nums[i]*sum)
	}

	return ans % 1000000007
}