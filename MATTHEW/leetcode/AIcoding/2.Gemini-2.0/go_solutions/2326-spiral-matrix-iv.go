type ListNode struct {
	Val  int
	Next *ListNode
}

func spiralMatrix(m int, n int, head *ListNode) [][]int {
	matrix := make([][]int, m)
	for i := range matrix {
		matrix[i] = make([]int, n)
		for j := range matrix[i] {
			matrix[i][j] = -1
		}
	}

	rowStart, rowEnd := 0, m-1
	colStart, colEnd := 0, n-1

	for head != nil && rowStart <= rowEnd && colStart <= colEnd {
		// Traverse right
		for i := colStart; i <= colEnd && head != nil; i++ {
			matrix[rowStart][i] = head.Val
			head = head.Next
		}
		rowStart++

		// Traverse down
		for i := rowStart; i <= rowEnd && head != nil; i++ {
			matrix[i][colEnd] = head.Val
			head = head.Next
		}
		colEnd--

		// Traverse left
		for i := colEnd; i >= colStart && head != nil; i-- {
			matrix[rowEnd][i] = head.Val
			head = head.Next
		}
		rowEnd--

		// Traverse up
		for i := rowEnd; i >= rowStart && head != nil; i-- {
			matrix[i][colStart] = head.Val
			head = head.Next
		}
		colStart++
	}

	return matrix
}