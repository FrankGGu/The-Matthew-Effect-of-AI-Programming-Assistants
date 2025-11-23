import (
	"math"
)

func minimumCircles(radii []int) int {
	n := len(radii)
	circles := make([][]float64, n)
	for i := range circles {
		circles[i] = make([]float64, 2)
	}

	var solve func(int) bool
	solve = func(k int) bool {
		if k == n {
			return true
		}

		for i := 0; i < (1 << (2 * k)); i++ {
			circles[k][0] = float64(i & 3)
			circles[k][1] = float64((i >> 2) & 3)

			valid := true
			for j := 0; j < k; j++ {
				dx := circles[k][0] - circles[j][0]
				dy := circles[k][1] - circles[j][1]
				distSq := dx*dx + dy*dy
				sumRadii := float64(radii[k]+radii[j])
				if distSq < sumRadii*sumRadii {
					valid = false
					break
				}
			}

			if valid {
				if solve(k + 1) {
					return true
				}
			}
		}

		return false
	}

	if solve(0) {
		maxX, maxY := 0.0, 0.0
		for i := 0; i < n; i++ {
			maxX = math.Max(maxX, circles[i][0]+float64(radii[i]))
			maxY = math.Max(maxY, circles[i][1]+float64(radii[i]))
		}
		return int(math.Ceil(math.Max(maxX, maxY)))
	}

	return -1
}