func lexicographicallySmallestArray(nums []int, limit int) []int {
	n := len(nums)
	indices := make([]int, n)
	for i := range nums {
		indices[i] = i
	}
	sort.Slice(indices, func(i, j int) bool {
		return nums[indices[i]] < nums[indices[j]]
	})

	visited := make([]bool, n)
	result := make([]int, n)

	for i := 0; i < n; i++ {
		if visited[indices[i]] {
			continue
		}

		group := []int{indices[i]}
		visited[indices[i]] = true

		for j := i + 1; j < n; j++ {
			if visited[indices[j]] {
				continue
			}

			canAdd := true
			for _, idx := range group {
				if abs(idx-indices[j]) > limit {
					canAdd = false
					break
				}
			}

			if canAdd {
				group = append(group, indices[j])
				visited[indices[j]] = true
			}
		}

		sort.Ints(group)

		values := make([]int, len(group))
		for k := range group {
			values[k] = nums[group[k]]
		}
		sort.Ints(values)

		for k := range group {
			result[group[k]] = values[k]
		}
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

import "sort"