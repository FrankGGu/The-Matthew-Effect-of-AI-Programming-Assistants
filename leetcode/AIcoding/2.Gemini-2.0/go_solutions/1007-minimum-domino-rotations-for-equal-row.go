func minDominoRotations(tops []int, bottoms []int) int {
	n := len(tops)
	rotations := func(target int) int {
		rotationsA, rotationsB := 0, 0
		for i := 0; i < n; i++ {
			if tops[i] != target && bottoms[i] != target {
				return -1
			}
			if tops[i] != target {
				rotationsA++
			}
			if bottoms[i] != target {
				rotationsB++
			}
		}
		return min(rotationsA, rotationsB)
	}

	res := rotations(tops[0])
	if res != -1 {
		return res
	}
	return rotations(bottoms[0])
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}