import "sort"

func findScore(nums []int) int64 {
	n := len(nums)
	marked := make([]bool, n)
	var score int64
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		if nums[indices[i]] == nums[indices[j]] {
			return indices[i] < indices[j]
		}
		return nums[indices[i]] < nums[indices[j]]
	})

	for _, i := range indices {
		if !marked[i] {
			score += int64(nums[i])
			marked[i] = true
			if i > 0 {
				marked[i-1] = true
			}
			if i < n-1 {
				marked[i+1] = true
			}
		}
	}

	return score
}