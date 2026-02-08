var ans int

func numValidMoveCombinations(pieces []string, positions [][]int) int {
	ans = 0
	occupied := make(map[int]bool)
	backtrack(0, pieces, positions, occupied)
	return ans
}

func backtrack(k int, pieces []string, positions [][]int, occupied map[int]bool) {
	if k == len(pieces) {
		ans++
		return
	}

	pieceType := pieces[k]
	startR, startC := positions[k][0], positions[k][1]

	possibleMoves := getAllMoves(pieceType, startR, startC)

	for _, move := range possibleMoves {
		targetR, targetC := move[0], move[1]
		key := targetR*8 + targetC

		if !occupied[key] {
			occupied[key] = true
			backtrack(k+1, pieces, positions, occupied)
			delete(occupied, key)
		}
	}
}

func getAllMoves(pieceType string, r, c int) [][]int {
	moves := [][]int{}
	rookDirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	bishopDirs := [][]int{{1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

	var currentDirs [][]int
	switch pieceType {
	case "rook":
		currentDirs = rookDirs
	case "bishop":
		currentDirs = bishopDirs
	case "queen":
		currentDirs = append(rookDirs, bishopDirs...)
	}

	for _, dir := range currentDirs {
		dr, dc := dir[0], dir[1]
		for i := 1; i < 8; i++ {
			nextR, nextC := r+dr*i, c+dc*i
			if isValid(nextR, nextC) {
				moves = append(moves, []int{nextR, nextC})
			} else {
				break
			}
		}
	}
	return moves
}

func isValid(r, c int) bool {
	return r >= 0 && r < 8 && c >= 0 && c < 8
}