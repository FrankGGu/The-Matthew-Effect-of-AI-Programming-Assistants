import (
	"sort"
)

func minimumSwaps(nums []int) int {
	n := len(nums)
	indices := make([]int, n)
	for i := 0; i < n; i++ {
		indices[i] = i
	}

	digitSum := func(num int) int {
		sum := 0
		for num > 0 {
			sum += num % 10
			num /= 10
		}
		return sum
	}

	sort.Slice(indices, func(i, j int) bool {
		sumI := digitSum(nums[indices[i]])
		sumJ := digitSum(nums[indices[j]])
		if sumI != sumJ {
			return sumI < sumJ
		}
		return nums[indices[i]] < nums[indices[j]]
	})

	visited := make([]bool, n)
	swaps := 0
	for i := 0; i < n; i++ {
		if visited[i] || indices[i] == i {
			continue
		}

		cycleSize := 0
		j := i
		for !visited[j] {
			visited[j] = true
			j = indices[j]
			cycleSize++
		}

		swaps += cycleSize - 1
	}

	return swaps
}