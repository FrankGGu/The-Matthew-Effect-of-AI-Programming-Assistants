func flipAndInvertImage(image [][]int) [][]int {
	for i := 0; i < len(image); i++ {
		l, r := 0, len(image[i])-1
		for l < r {
			image[i][l], image[i][r] = image[i][r], image[i][l]
			l++
			r--
		}
		for j := 0; j < len(image[i]); j++ {
			image[i][j] = 1 - image[i][j]
		}
	}
	return image
}