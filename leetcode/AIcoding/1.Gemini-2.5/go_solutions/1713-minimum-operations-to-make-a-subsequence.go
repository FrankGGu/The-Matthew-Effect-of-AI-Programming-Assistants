import (
	"sort"
)

func minOperations(target []int, arr []int) int {
	targetMap := make(map[int]int, len(target))
	for i, val := range target {
		targetMap[val] = i
	}

	var subsequence []int
	for _, val := range arr {
		if idx, ok := targetMap[val]; ok {
			subsequence = append(subsequence, idx)
		}
	}

	if len(subsequence) == 0 {
		return len(target)
	}

	tails := make([]int, 0, len(subsequence))
	for _, num := range subsequence {
		i := sort.SearchInts(tails, num)
		if i == len(tails) {
			tails = append(tails, num)
		} else {
			tails[i] = num
		}
	}

	return len(target) - len(tails)
}