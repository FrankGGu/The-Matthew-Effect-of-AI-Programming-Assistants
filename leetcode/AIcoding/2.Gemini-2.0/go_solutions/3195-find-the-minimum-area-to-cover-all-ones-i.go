import "math"

func minArea(image []string, x int, y int) int {
	m := len(image)
	n := len(image[0])

	left := findLeft(image, 0, y)
	right := findRight(image, y, n-1)
	top := findTop(image, 0, x)
	bottom := findBottom(image, x, m-1)

	return (right - left + 1) * (bottom - top + 1)
}

func findLeft(image []string, start int, end int) int {
	for start < end {
		mid := start + (end-start)/2
		found := false
		for i := 0; i < len(image); i++ {
			if image[i][mid] == '1' {
				found = true
				break
			}
		}
		if found {
			end = mid
		} else {
			start = mid + 1
		}
	}
	return start
}

func findRight(image []string, start int, end int) int {
	for start < end {
		mid := start + (end-start+1)/2
		found := false
		for i := 0; i < len(image); i++ {
			if image[i][mid] == '1' {
				found = true
				break
			}
		}
		if found {
			start = mid
		} else {
			end = mid - 1
		}
	}
	return start
}

func findTop(image []string, start int, end int) int {
	for start < end {
		mid := start + (end-start)/2
		found := false
		for j := 0; j < len(image[0]); j++ {
			if image[mid][j] == '1' {
				found = true
				break
			}
		}
		if found {
			end = mid
		} else {
			start = mid + 1
		}
	}
	return start
}

func findBottom(image []string, start int, end int) int {
	for start < end {
		mid := start + (end-start+1)/2
		found := false
		for j := 0; j < len(image[0]); j++ {
			if image[mid][j] == '1' {
				found = true
				break
			}
		}
		if found {
			start = mid
		} else {
			end = mid - 1
		}
	}
	return start
}