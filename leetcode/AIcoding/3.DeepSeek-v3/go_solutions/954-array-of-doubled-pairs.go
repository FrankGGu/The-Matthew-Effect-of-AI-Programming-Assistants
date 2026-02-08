import (
	"sort"
)

func canReorderDoubled(arr []int) bool {
	count := make(map[int]int)
	for _, num := range arr {
		count[num]++
	}

	unique := make([]int, 0, len(count))
	for num := range count {
		unique = append(unique, num)
	}

	sort.Slice(unique, func(i, j int) bool {
		return abs(unique[i]) < abs(unique[j])
	})

	for _, num := range unique {
		if count[num] == 0 {
			continue
		}
		if count[2*num] < count[num] {
			return false
		}
		count[2*num] -= count[num]
	}

	return true
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}