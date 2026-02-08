import "sort"
import "strconv"

func sortJumbled(mapping []int, nums []int) []int {
	n := len(nums)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		numI := nums[indices[i]]
		numJ := nums[indices[j]]
		mappedI := mapNumber(numI, mapping)
		mappedJ := mapNumber(numJ, mapping)
		return mappedI < mappedJ
	})

	result := make([]int, n)
	for i := range result {
		result[i] = nums[indices[i]]
	}

	return result
}

func mapNumber(num int, mapping []int) int {
	s := strconv.Itoa(num)
	mapped := ""
	for _, char := range s {
		digit := int(char - '0')
		mapped += strconv.Itoa(mapping[digit])
	}

	if mapped == "" {
		return 0
	}

	result, _ := strconv.Atoi(mapped)
	return result
}