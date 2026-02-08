import "sort"

func diagonalSort(mat [][]int) [][]int {
	m := len(mat)
	n := len(mat[0])

	// Sort diagonals starting from the first row (column 0 to n-1)
	for j := 0; j < n; j++ {
		diag := []int{}
		r, c := 0, j
		for r < m && c < n {
			diag = append(diag, mat[r][c])
			r++
			c++
		}
		sort.Ints(diag)

		r, c = 0, j
		k := 0 // index for sorted diag
		for r < m && c < n {
			mat[r][c] = diag[k]
			r++
			c++
			k++
		}
	}

	// Sort diagonals starting from the first column (row 1 to m-1)
	for i := 1; i < m; i++ { // Start from row 1 as row 0 (i=0) diagonals are covered by the first loop
		diag := []int{}
		r, c := i, 0
		for r < m && c < n {
			diag = append(diag, mat[r][c])
			r++
			c++
		}
		sort.Ints(diag)

		r, c = i, 0
		k := 0 // index for sorted diag
		for r < m && c < n {
			mat[r][c] = diag[k]
			r++
			c++
			k++
		}
	}

	return mat
}