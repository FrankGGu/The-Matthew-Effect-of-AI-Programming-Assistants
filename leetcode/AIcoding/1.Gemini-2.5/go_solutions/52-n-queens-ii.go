package main

func totalNQueens(n int) int {
	count := 0
	cols := make([]bool, n)
	diag1 := make([]bool, 2*n-1) // r + c
	diag2 := make([]bool, 2*n-1) // r - c + n - 1

	var backtrack func(row int)
	backtrack = func(row int) {
		if row == n {
			count++
			return
		}

		for col := 0; col < n; col++ {
			if !cols[col] && !diag1[row+col] && !diag2[row-col+n-1] {
				cols[col] = true
				diag1[row+col] = true
				diag2[row-col+n-1] = true

				backtrack(row + 1)

				cols[col] = false
				diag1[row+col] = false
				diag2[row-col+n-1] = false
			}
		}
	}

	backtrack(0)
	return count
}