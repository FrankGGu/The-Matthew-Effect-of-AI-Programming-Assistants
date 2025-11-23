func largestOverlap(img1 [][]int, img2 [][]int) int {
	n := len(img1)
	overlap := 0
	for xShift := -n + 1; xShift < n; xShift++ {
		for yShift := -n + 1; yShift < n; yShift++ {
			count := 0
			for i := 0; i < n; i++ {
				for j := 0; j < n; j++ {
					x2 := i + xShift
					y2 := j + yShift
					if x2 >= 0 && x2 < n && y2 >= 0 && y2 < n && img1[i][j] == 1 && img2[x2][y2] == 1 {
						count++
					}
				}
			}
			if count > overlap {
				overlap = count
			}
		}
	}
	return overlap
}