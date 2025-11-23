func relocateMarbles(nums []int, moveFrom []int, moveTo []int) []int {
	pos := make(map[int]bool)
	for _, num := range nums {
		pos[num] = true
	}

	for i := 0; i < len(moveFrom); i++ {
		if pos[moveFrom[i]] {
			pos[moveFrom[i]] = false
			pos[moveTo[i]] = true
		}
	}

	result := []int{}
	for num := range pos {
		if pos[num] {
			result = append(result, num)
		}
	}

	sort.Ints(result)
	return result
}

import "sort"