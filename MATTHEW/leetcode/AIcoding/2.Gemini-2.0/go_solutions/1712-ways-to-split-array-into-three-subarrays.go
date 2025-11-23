func waysToSplit(nums []int) int {
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	ans := 0
	mod := 1000000007

	for i := 1; i < n-1; i++ {
		leftSum := prefixSum[i]
		left := i
		right := n - 1

		low := -1
		for left <= right {
			mid := left + (right-left)/2
			midSum := prefixSum[mid] - leftSum
			remSum := prefixSum[n] - prefixSum[mid]

			if leftSum <= midSum {
				low = mid
				right = mid - 1
			} else {
				left = mid + 1
			}
		}

		left = i
		right = n - 1

		high := -1
		for left <= right {
			mid := left + (right-left)/2
			midSum := prefixSum[mid] - leftSum
			remSum := prefixSum[n] - prefixSum[mid]

			if midSum <= remSum {
				high = mid
				left = mid + 1
			} else {
				right = mid - 1
			}
		}

		if low != -1 && high != -1 && low <= high {
			ans = (ans + (high - low + 1)) % mod
		}
	}

	return ans
}