import "sort"

func maxSum(nums []int, m int, k int) int64 {
	n := len(nums)
	if n < m*k {
		return 0
	}

	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(nums[i])
	}

	sums := []int64{}
	for i := m; i <= n; i++ {
		for j := 0; j <= n-i; j++ {
			sums = append(sums, prefixSum[j+i]-prefixSum[j])
		}
	}

	sort.Slice(sums, func(i, j int) bool {
		return sums[i] > sums[j]
	})

	res := int64(0)
	for i := 0; i < min(k, len(sums)); i++ {
		res += sums[i]
	}

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}