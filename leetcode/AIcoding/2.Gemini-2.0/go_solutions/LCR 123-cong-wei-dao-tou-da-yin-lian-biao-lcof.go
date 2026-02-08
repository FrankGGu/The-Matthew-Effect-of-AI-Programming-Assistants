func sortBooks(books []int) []int {
	n := len(books)
	for i := 0; i < n-1; i++ {
		for j := 0; j < n-i-1; j++ {
			if books[j] > books[j+1] {
				books[j], books[j+1] = books[j+1], books[j]
			}
		}
	}
	return books
}