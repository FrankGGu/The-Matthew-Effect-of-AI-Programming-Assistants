import "sort"

func deckRevealedIncreasing(deck []int) []int {
	n := len(deck)
	sort.Ints(deck)
	res := make([]int, n)
	idx := make([]int, n)
	for i := 0; i < n; i++ {
		idx[i] = i
	}

	for i := 0; i < n; i++ {
		res[idx[0]] = deck[i]
		idx = idx[1:]
		if len(idx) > 0 {
			idx = append(idx, idx[0])
			idx = idx[1:]
		}
	}
	return res
}