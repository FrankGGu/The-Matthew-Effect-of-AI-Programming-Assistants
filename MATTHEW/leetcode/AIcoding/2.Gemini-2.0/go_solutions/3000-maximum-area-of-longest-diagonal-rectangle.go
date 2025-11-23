import "math"

func areaOfMaxDiagonal(dimensions [][]int) int {
	maxDiagonal := 0.0
	maxArea := 0
	for _, dim := range dimensions {
		l := dim[0]
		w := dim[1]
		diagonal := math.Sqrt(float64(l*l + w*w))
		area := l * w
		if diagonal > maxDiagonal {
			maxDiagonal = diagonal
			maxArea = area
		} else if diagonal == maxDiagonal && area > maxArea {
			maxArea = area
		}
	}
	return maxArea
}