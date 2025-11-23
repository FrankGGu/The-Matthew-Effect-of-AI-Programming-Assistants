import (
	"sort"
)

func maxWidthOfVerticalArea(points [][]int) int {
	xCoords := make([]int, len(points))
	for i, p := range points {
		xCoords[i] = p[0]
	}

	sort.Ints(xCoords)

	maxWidth := 0
	for i := 1; i < len(xCoords); i++ {
		diff := xCoords[i] - xCoords[i-1]
		if diff > maxWidth {
			maxWidth = diff
		}
	}

	return maxWidth
}