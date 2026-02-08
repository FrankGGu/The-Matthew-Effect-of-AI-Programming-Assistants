import "sort"

func maxNonDecreasingLength(nums []int) int {
	n := len(nums)
	dp := make([]int, n)
	dp[0] = 1
	sums := make([]int, n)
	sums[0] = nums[0]
	for i := 1; i < n; i++ {
		sums[i] = sums[i-1] + nums[i]
	}
	tails := []int{nums[0]}
	indices := []int{0}

	for i := 1; i < n; i++ {
		dp[i] = 1
		idx := sort.Search(len(tails), func(j int) bool {
			return tails[j] <= nums[i]
		})
		if idx > 0 {
			dp[i] = dp[indices[idx-1]] + 1
		}

		sum := sums[i]
		low := 0
		high := len(indices)
		for low < high {
			mid := (low + high) / 2
			if sums[i] - sums[indices[mid]] >= tails[mid] {
				low = mid + 1
			} else {
				high = mid
			}
		}
		if low > 0 {
			dp[i] = max(dp[i], dp[indices[low-1]]+1)
		}

		if len(tails) == 0 || nums[i] >= tails[len(tails)-1] {
			tails = append(tails, nums[i])
			indices = append(indices, i)
		} else {
			idx := sort.Search(len(tails), func(j int) bool {
				return tails[j] > nums[i]
			})
			tails[idx] = nums[i]
			indices[idx] = i
		}
	}

	ans := 0
	for _, v := range dp {
		ans = max(ans, v)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}