func findDiagonalOrder(nums [][]int) []int {
	// Create a map to store elements for each diagonal sum (i+j)
	// The key is i+j, and the value is a slice of integers belonging to that diagonal.
	// Elements are appended in the order they are encountered (row by row, column by column).