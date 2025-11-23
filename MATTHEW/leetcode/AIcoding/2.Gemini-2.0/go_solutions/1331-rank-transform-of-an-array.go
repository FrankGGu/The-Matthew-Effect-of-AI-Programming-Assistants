import (
	"sort"
)

func arrayRankTransform(arr []int) []int {
	n := len(arr)
	if n == 0 {
		return []int{}
	}

	sortedArr := make([]int, n)
	copy(sortedArr, arr)
	sort.Ints(sortedArr)

	rankMap := make(map[int]int)
	rank := 1
	for i := 0; i < n; i++ {
		if _, ok := rankMap[sortedArr[i]]; !ok {
			rankMap[sortedArr[i]] = rank
			rank++
		}
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		result[i] = rankMap[arr[i]]
	}

	return result
}