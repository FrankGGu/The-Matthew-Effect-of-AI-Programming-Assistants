import "sort"

func maxSubsequence(nums []int, k int) []int {
	n := len(nums)
	indices := make([]int, n)
	for i := 0; i < n; i++ {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return nums[indices[i]] > nums[indices[j]]
	})

	selectedIndices := indices[:k]
	sort.Ints(selectedIndices)

	result := make([]int, k)
	for i := 0; i < k; i++ {
		result[i] = nums[selectedIndices[i]]
	}

	return result
}