import (
	"sort"
)

func advantageCount(A []int, B []int) []int {
	n := len(A)
	sortedA := make([]int, n)
	copy(sortedA, A)
	sort.Ints(sortedA)
	sortedB := make([]int, n)
	copy(sortedB, B)
	sort.Ints(sortedB)

	assigned := make(map[int][]int)
	remaining := make([]int, 0)

	j := 0
	for _, a := range sortedA {
		if a > sortedB[j] {
			if assigned[sortedB[j]] == nil {
				assigned[sortedB[j]] = make([]int, 0)
			}
			assigned[sortedB[j]] = append(assigned[sortedB[j]], a)
			j++
		} else {
			remaining = append(remaining, a)
		}
	}

	result := make([]int, n)
	for i := 0; i < n; i++ {
		if list, ok := assigned[B[i]]; ok && len(list) > 0 {
			result[i] = list[len(list)-1]
			assigned[B[i]] = list[:len(list)-1]
		} else {
			result[i] = remaining[len(remaining)-1]
			remaining = remaining[:len(remaining)-1]
		}
	}
	return result
}