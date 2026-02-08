import "sort"

func longestSubsequence(nums []int, queries []int) []int {
	sort.Ints(nums)
	prefixSum := make([]int, len(nums)+1)
	for i := 1; i <= len(nums); i++ {
		prefixSum[i] = prefixSum[i-1] + nums[i-1]
	}

	ans := make([]int, len(queries))
	for i, q := range queries {
		l, r := 0, len(nums)
		for l <= r {
			mid := l + (r-l)/2
			if mid > 0 && prefixSum[mid] <= q {
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
		ans[i] = r
	}
	return ans
}