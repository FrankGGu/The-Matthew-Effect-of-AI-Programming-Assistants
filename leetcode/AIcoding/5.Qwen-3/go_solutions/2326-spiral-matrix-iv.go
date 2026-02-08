package main


func spiralMatrix(m int, n int, head *ListNode) [][]int {
	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
	}

	top := 0
	bottom := m - 1
	left := 0
	right := n - 1

	for head != nil && top <= bottom && left <= right {
		for i := left; i <= right && head != nil; i++ {
			result[top][i] = head.Val
			head = head.Next
		}
		top++

		for i := top; i <= bottom && head != nil; i++ {
			result[i][right] = head.Val
			head = head.Next
		}
		right--

		for i := right; i >= left && head != nil; i-- {
			result[bottom][i] = head.Val
			head = head.Next
		}
		bottom--

		for i := bottom; i >= top && head != nil; i-- {
			result[i][left] = head.Val
			head = head.Next
		}
		left++
	}

	return result
}