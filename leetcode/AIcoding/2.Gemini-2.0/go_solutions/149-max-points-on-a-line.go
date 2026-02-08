import "fmt"

func maxPoints(points [][]int) int {
	n := len(points)
	if n <= 2 {
		return n
	}

	maxCount := 0
	for i := 0; i < n; i++ {
		slopes := make(map[float64]int)
		samePoints := 1
		vertical := 0
		for j := i + 1; j < n; j++ {
			if points[i][0] == points[j][0] && points[i][1] == points[j][1] {
				samePoints++
			} else if points[i][0] == points[j][0] {
				vertical++
			} else {
				slope := float64(points[i][1]-points[j][1]) / float64(points[i][0]-points[j][0])
				slopes[slope]++
			}
		}

		currentMax := vertical
		for _, count := range slopes {
			if count > currentMax {
				currentMax = count
			}
		}

		if samePoints > maxCount {
			maxCount = samePoints
		}

		if currentMax+samePoints > maxCount {
			maxCount = currentMax + samePoints
		}

	}

	return maxCount
}