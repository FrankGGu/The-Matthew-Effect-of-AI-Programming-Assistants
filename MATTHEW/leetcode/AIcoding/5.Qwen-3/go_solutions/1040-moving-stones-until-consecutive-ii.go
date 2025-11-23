package main

func numMovesStonesII(positions []int) int {
	n := len(positions)
	sort.Ints(positions)
	minMoves := 0
	for i := 0; i < n-1; i++ {
		if positions[i+1]-positions[i] > 1 {
			minMoves += positions[i+1] - positions[i] - 1
		}
	}
	return minMoves
}