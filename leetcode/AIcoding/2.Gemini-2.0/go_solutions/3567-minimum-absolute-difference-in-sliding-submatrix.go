import (
	"sort"
)

func minDifference(mat [][]int, k int) int {
	n := len(mat)
	m := len(mat[0])
	minDiff := 100001

	for i := 0; i <= n-k; i++ {
		for j := 0; j <= m-k; j++ {
			nums := []int{}
			for row := i; row < i+k; row++ {
				for col := j; col < j+k; col++ {
					nums = append(nums, mat[row][col])
				}
			}

			sort.Ints(nums)

			for l := 0; l <= len(nums)-k*k/2-1; l++ {
				median := nums[l+k*k/2]
				diff := 0
				for _, num := range nums {
					diff += abs(num - median)
				}
				minDiff = min(minDiff, diff)
			}
		}
	}

	return minDiff
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}