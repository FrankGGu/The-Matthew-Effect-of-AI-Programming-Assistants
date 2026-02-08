import "sort"

func kWeakestRows(mat [][]int, k int) []int {
	rows := make([]int, len(mat))
	for i := range mat {
		for j := range mat[i] {
			if mat[i][j] == 1 {
				rows[i]++
			} else {
				break
			}
		}
	}

	type RowStrength struct {
		Index   int
		Strength int
	}

	rowStrengths := make([]RowStrength, len(mat))
	for i := range mat {
		rowStrengths[i] = RowStrength{Index: i, Strength: rows[i]}
	}

	sort.Slice(rowStrengths, func(i, j int) bool {
		if rowStrengths[i].Strength == rowStrengths[j].Strength {
			return rowStrengths[i].Index < rowStrengths[j].Index
		}
		return rowStrengths[i].Strength < rowStrengths[j].Strength
	})

	result := make([]int, k)
	for i := 0; i < k; i++ {
		result[i] = rowStrengths[i].Index
	}

	return result
}