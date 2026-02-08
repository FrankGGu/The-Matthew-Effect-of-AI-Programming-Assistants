func canFormArray(arr []int, pieces [][]int) bool {
	pieceMap := make(map[int][]int)
	for _, piece := range pieces {
		pieceMap[piece[0]] = piece
	}

	i := 0
	for i < len(arr) {
		piece, ok := pieceMap[arr[i]]
		if !ok {
			return false
		}

		for j := 0; j < len(piece); j++ {
			if i >= len(arr) || arr[i] != piece[j] {
				return false
			}
			i++
		}
	}

	return true
}