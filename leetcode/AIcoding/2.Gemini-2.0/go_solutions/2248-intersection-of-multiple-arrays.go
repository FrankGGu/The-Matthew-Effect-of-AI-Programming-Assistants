func intersection(nums [][]int) []int {
	if len(nums) == 0 {
		return []int{}
	}

	counts := make(map[int]int)
	for _, arr := range nums {
		for _, num := range arr {
			counts[num]++
		}
	}

	result := []int{}
	for num, count := range counts {
		if count == len(nums) {
			result = append(result, num)
		}
	}

	sort.Ints(result)
	return result
}

import "sort"