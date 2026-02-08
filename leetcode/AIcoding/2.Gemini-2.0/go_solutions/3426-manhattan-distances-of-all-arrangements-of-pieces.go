import (
	"sort"
)

func solve(pieces [][]int) []int {
	n := len(pieces)
	m := len(pieces[0])

	totalArrangements := 1
	for i := 1; i <= n*m; i++ {
		totalArrangements *= i
	}

	result := make([]int, totalArrangements)
	arrangements := make([][]int, 0)
	nums := make([]int, n*m)
	for i := 0; i < n*m; i++ {
		nums[i] = i
	}

	var permute func([]int, int)
	permute = func(nums []int, l int) {
		if l == len(nums) {
			temp := make([]int, len(nums))
			copy(temp, nums)
			arrangements = append(arrangements, temp)
			return
		}
		for i := l; i < len(nums); i++ {
			nums[l], nums[i] = nums[i], nums[l]
			permute(nums, l+1)
			nums[l], nums[i] = nums[i], nums[l]
		}
	}

	permute(nums, 0)
	sort.Slice(arrangements, func(i, j int) bool {
		for k := 0; k < len(arrangements[i]); k++ {
			if arrangements[i][k] != arrangements[j][k] {
				return arrangements[i][k] < arrangements[j][k]
			}
		}
		return false
	})

	for i := 0; i < totalArrangements; i++ {
		distance := 0
		for j := 0; j < n*m; j++ {
			x1 := j / m
			y1 := j % m
			x2 := arrangements[i][j] / m
			y2 := arrangements[i][j] % m
			distance += abs(x1-x2) + abs(y1-y2)
		}
		result[i] = distance
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}