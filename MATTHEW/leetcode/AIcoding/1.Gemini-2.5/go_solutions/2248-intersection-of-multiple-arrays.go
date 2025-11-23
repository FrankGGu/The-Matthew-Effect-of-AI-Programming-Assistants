import (
	"sort"
)

func intersection(nums [][]int) []int {
	if len(nums) == 0 {
		return []int{}
	}

	freq := make([]int, 1001) // Max value of nums[i][j] is 1000

	for _, arr := range nums {
		for _, num := range arr {
			freq[num]++
		}
	}

	var result []int
	numArrays := len(nums)

	for i := 1; i <= 1000; i++ {
		if freq[i] == numArrays {
			result = append(result, i)
		}
	}

	// The loop above iterates from 1 to 1000, so the result is already sorted.
	// No explicit sort.Ints(result) is needed.

	return result
}