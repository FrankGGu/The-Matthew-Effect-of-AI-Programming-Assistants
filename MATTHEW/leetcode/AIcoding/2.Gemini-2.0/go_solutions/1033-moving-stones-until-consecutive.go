import (
	"sort"
)

func numMovesStones(a int, b int, c int) []int {
	stones := []int{a, b, c}
	sort.Ints(stones)
	a = stones[0]
	b = stones[1]
	c = stones[2]

	minMoves := 0
	if b-a == 1 && c-b == 1 {
		minMoves = 0
	} else if b-a <= 2 || c-b <= 2 {
		minMoves = 1
	} else {
		minMoves = 2
	}

	maxMoves := c - a - 2

	return []int{minMoves, maxMoves}
}