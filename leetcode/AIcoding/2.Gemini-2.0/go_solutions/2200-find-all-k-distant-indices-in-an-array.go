func findKDistantIndices(nums []int, key int, k int) []int {
	n := len(nums)
	result := []int{}
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if nums[j] == key && abs(i-j) <= k {
				result = append(result, i)
				break
			}
		}
	}

	uniqueResult := []int{}
	seen := make(map[int]bool)
	for _, val := range result {
		if !seen[val] {
			uniqueResult = append(uniqueResult, val)
			seen[val] = true
		}
	}

	sort.Ints(uniqueResult)
	return uniqueResult
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

import "sort"