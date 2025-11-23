import (
	"sort"
)

func minOperations(nums []int, queries []int) []int64 {
	sort.Ints(nums)
	n := len(nums)
	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(nums[i])
	}

	result := make([]int64, len(queries))
	for i, query := range queries {
		left := sort.SearchInts(nums, query)
		less := int64(left)
		greater := int64(n - left)
		lessSum := int64(query)*less - (prefixSum[left])
		greaterSum := (prefixSum[n] - prefixSum[left]) - int64(query)*greater
		result[i] = lessSum + greaterSum
	}

	return result
}