func findDiagonalOrder(nums [][]int) []int {
	m := len(nums)
	diagonalMap := make(map[int][]int)

	for i := 0; i < m; i++ {
		n := len(nums[i])
		for j := 0; j < n; j++ {
			diagonalMap[i+j] = append(diagonalMap[i+j], nums[i][j])
		}
	}

	keys := make([]int, 0, len(diagonalMap))
	for k := range diagonalMap {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	result := make([]int, 0)
	for _, k := range keys {
		for i := len(diagonalMap[k]) - 1; i >= 0; i-- {
			result = append(result, diagonalMap[k][i])
		}
	}

	return result
}

import "sort"