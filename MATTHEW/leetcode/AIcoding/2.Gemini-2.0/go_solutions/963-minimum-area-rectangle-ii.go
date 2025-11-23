import (
	"math"
)

func minAreaFreeRect(points [][]int) float64 {
	n := len(points)
	if n < 4 {
		return 0
	}

	pointMap := make(map[int]map[int]bool)
	for _, p := range points {
		x, y := p[0], p[1]
		if _, ok := pointMap[x]; !ok {
			pointMap[x] = make(map[int]bool)
		}
		pointMap[x][y] = true
	}

	minArea := math.MaxFloat64

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				p1 := points[i]
				p2 := points[j]
				p3 := points[k]

				// Check if p1-p2-p3 form a right angle at p1
				if (p2[0]-p1[0])*(p3[0]-p1[0])+(p2[1]-p1[1])*(p3[1]-p1[1]) == 0 {
					// Calculate the fourth point
					p4x := p2[0] + p3[0] - p1[0]
					p4y := p2[1] + p3[1] - p1[1]

					// Check if the fourth point exists
					if _, ok := pointMap[p4x]; ok {
						if _, ok2 := pointMap[p4x][p4y]; ok2 {
							// Calculate the area
							side1 := math.Sqrt(math.Pow(float64(p2[0]-p1[0]), 2) + math.Pow(float64(p2[1]-p1[1]), 2))
							side2 := math.Sqrt(math.Pow(float64(p3[0]-p1[0]), 2) + math.Pow(float64(p3[1]-p1[1]), 2))
							area := side1 * side2

							// Update the minimum area
							minArea = math.Min(minArea, area)
						}
					}
				}

				// Check if p1-p2-p3 form a right angle at p2
				if (p1[0]-p2[0])*(p3[0]-p2[0])+(p1[1]-p2[1])*(p3[1]-p2[1]) == 0 {
					// Calculate the fourth point
					p4x := p1[0] + p3[0] - p2[0]
					p4y := p1[1] + p3[1] - p2[1]

					// Check if the fourth point exists
					if _, ok := pointMap[p4x]; ok {
						if _, ok2 := pointMap[p4x][p4y]; ok2 {
							// Calculate the area
							side1 := math.Sqrt(math.Pow(float64(p1[0]-p2[0]), 2) + math.Pow(float64(p1[1]-p2[1]), 2))
							side2 := math.Sqrt(math.Pow(float64(p3[0]-p2[0]), 2) + math.Pow(float64(p3[1]-p2[1]), 2))
							area := side1 * side2

							// Update the minimum area
							minArea = math.Min(minArea, area)
						}
					}
				}

				// Check if p1-p2-p3 form a right angle at p3
				if (p1[0]-p3[0])*(p2[0]-p3[0])+(p1[1]-p3[1])*(p2[1]-p3[1]) == 0 {
					// Calculate the fourth point
					p4x := p1[0] + p2[0] - p3[0]
					p4y := p1[1] + p2[1] - p3[1]

					// Check if the fourth point exists
					if _, ok := pointMap[p4x]; ok {
						if _, ok2 := pointMap[p4x][p4y]; ok2 {
							// Calculate the area
							side1 := math.Sqrt(math.Pow(float64(p1[0]-p3[0]), 2) + math.Pow(float64(p1[1]-p3[1]), 2))
							side2 := math.Sqrt(math.Pow(float64(p2[0]-p3[0]), 2) + math.Pow(float64(p2[1]-p3[1]), 2))
							area := side1 * side2

							// Update the minimum area
							minArea = math.Min(minArea, area)
						}
					}
				}
			}
		}
	}

	if minArea == math.MaxFloat64 {
		return 0
	}

	return minArea
}