import (
	"fmt"
	"sort"
)

func minOperations(grid [][]int, x int) int {
	m := len(grid)
	n := len(grid[0])
	nums := make([]int, 0, m*n)
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			nums = append(nums, grid[i][j])
		}
	}
	sort.Ints(nums)
	median := nums[(m*n)/2]
	ops := 0
	for _, num := range nums {
		diff := abs(num - median)
		if diff%x != 0 {
			return -1
		}
		ops += diff / x
	}
	return ops
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}