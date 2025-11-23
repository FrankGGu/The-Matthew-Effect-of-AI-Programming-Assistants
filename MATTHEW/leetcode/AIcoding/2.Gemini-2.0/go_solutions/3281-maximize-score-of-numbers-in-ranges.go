func maximizeScore(nums []int, quantity []int) int {
	n := len(nums)
	m := len(quantity)

	sort.Ints(nums)
	sort.Ints(quantity)

	check := func(mid int) bool {
		count := make([]int, n)
		for i := 0; i < n; i++ {
			if nums[i] >= mid {
				count[i] = 1
			}
		}

		prefixSum := make([]int, n+1)
		for i := 0; i < n; i++ {
			prefixSum[i+1] = prefixSum[i] + count[i]
		}

		for i := m - 1; i >= 0; i-- {
			if prefixSum[n] < quantity[i] {
				return false
			}

			found := false
			for j := n; j > 0; j-- {
				if prefixSum[j] >= quantity[i] {
					n = j - 1
					found = true
					break
				}
			}
			if !found {
				return false
			}
		}
		return true
	}

	left, right := 0, nums[n-1]
	ans := 0
	for left <= right {
		mid := left + (right-left)/2
		if check(mid) {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return ans
}