import "sort"

func maxConsecutive(bottom int, top int, special []int) int {
	sort.Ints(special)
	maxConsecutive := max(special[0]-bottom, top-special[len(special)-1])

	for i := 1; i < len(special); i++ {
		maxConsecutive = max(maxConsecutive, special[i]-special[i-1]-1)
	}

	return maxConsecutive
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}