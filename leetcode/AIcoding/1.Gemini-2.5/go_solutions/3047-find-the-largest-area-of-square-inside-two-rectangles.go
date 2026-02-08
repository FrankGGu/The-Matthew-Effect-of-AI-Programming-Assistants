import "math"

func largestSquareArea(bottomLeft [][]int, topRight [][]int) int {
    // Coordinates for rectangle 1
    x1_1, y1_1 := bottomLeft[0][0], bottomLeft[0][1]
    x2_1, y2_1 := topRight[0][0], topRight