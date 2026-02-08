package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func largestOverlap(img1 [][]int, img2 [][]int) int {
	n := len(img1)
	maxOverlap := 0

	// Iterate through all possible vertical shifts (dy) of img2 relative to img1.
	// dy ranges from -(n-1) (img2 shifted up by n-1) to n-1 (img2 shifted down by n-1).
	for dy := -(n - 1); dy < n; dy++ {
		// Iterate through all possible horizontal shifts (dx) of img2 relative to img1.
		// dx ranges from -(n-1) (img2 shifted left by n-1) to n-1 (img2 shifted right by n-1).
		for dx := -(n - 1); dx < n; dx++ {
			currentOverlap := 0
			// Iterate through all cells (r, c) of img1.
			for r := 0; r < n; r++ {
				for c := 0; c < n; c++ {
					// If img1[r][c] is a '1'
					if img1[r][c] == 1 {
						// Calculate the corresponding coordinates in img2 for the current (r, c) in img1.
						// If img2 is shifted by (dy, dx) relative to img1,
						// then img1[r][c] aligns with img2[r-dy][c-dx].
						rImg2 := r - dy
						cImg2 := c - dx

						// Check if the corresponding coordinates in img2 are within its bounds.
						if rImg2 >= 0 && rImg2 < n && cImg2 >= 0 && cImg2 < n {
							// If img2[rImg2][cImg2] is also a '1', increment overlap.
							if img2[rImg2][cImg2] == 1 {
								currentOverlap++
							}
						}
					}
				}
			}
			// Update maxOverlap with the maximum overlap found so far.
			maxOverlap = max(maxOverlap, currentOverlap)
		}
	}

	return maxOverlap
}