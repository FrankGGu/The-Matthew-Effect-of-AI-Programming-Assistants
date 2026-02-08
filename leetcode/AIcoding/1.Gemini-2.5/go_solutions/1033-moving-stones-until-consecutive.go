package main

import "sort"

func numMovesStones(a int, b int, c int) []int {
	stones := []int{a, b, c}
	sort.Ints(stones)
	x, y, z := stones[0], stones[1], stones[2]

	minMoves := 0
	if z-x == 2 {
		minMoves = 0
	} else if y-x == 1 || z-y == 1 {
		minMoves = 1
	} else {
		minMoves = 2
	}

	maxMoves := (y - x - 1) + (z - y - 1)

	return []int{minMoves, maxMoves}
}