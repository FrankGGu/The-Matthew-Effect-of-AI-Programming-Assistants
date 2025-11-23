import (
	"math"
	"sort"
)

func minArea(image [][]byte, x int, y int) int {
	m := len(image)
	n := len(image[0])

	top := searchVertical(image, 0, x, 0, n-1, true)
	bottom := searchVertical(image, x+1, m-1, 0, n-1, false)
	left := searchHorizontal(image, 0, y, top, bottom, true)
	right := searchHorizontal(image, y+1, n-1, top, bottom, false)

	return (bottom - top + 1) * (right - left + 1)
}

func searchVertical(image [][]byte, start int, end int, left int, right int, findMin bool) int {
	for start < end {
		mid := start + (end-start)/2
		hasOne := false
		for j := left; j <= right; j++ {
			if image[mid][j] == '1' {
				hasOne = true
				break
			}
		}

		if hasOne {
			if findMin {
				end = mid
			} else {
				start = mid + 1
			}
		} else {
			if findMin {
				start = mid + 1
			} else {
				end = mid
			}
		}
	}

	if findMin {
		return start
	}

	return end
}

func searchHorizontal(image [][]byte, start int, end int, top int, bottom int, findMin bool) int {
	for start < end {
		mid := start + (end-start)/2
		hasOne := false
		for i := top; i <= bottom; i++ {
			if image[i][mid] == '1' {
				hasOne = true
				break
			}
		}

		if hasOne {
			if findMin {
				end = mid
			} else {
				start = mid + 1
			}
		} else {
			if findMin {
				start = mid + 1
			} else {
				end = mid
			}
		}
	}

	if findMin {
		return start
	}

	return end
}