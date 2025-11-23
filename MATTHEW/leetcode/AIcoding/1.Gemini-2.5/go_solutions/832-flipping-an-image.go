func flipAndInvertImage(image [][]int) [][]int {
	for _, row := range image {
		n := len(row)
		for i := 0; i < n/2; i++ {
			// Swap and invert simultaneously
			// original: row[i], row[n-1-i]
			// after reverse: row[n-1-i], row[i]
			// after invert: 1-row[n-1-i], 1-row[i]
			row[i], row[n-1-i] = 1-row[n-1-i], 1-row[i]
		}
		if n%2 == 1 {
			// Invert the middle element if the row has odd length
			row[n/2] = 1 - row[n/2]
		}
	}
	return image
}