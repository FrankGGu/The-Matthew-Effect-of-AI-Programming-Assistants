import (
	"math"
)

func getMinDistSum(positions [][]int) float64 {
	n := len(positions)
	xSum, ySum := 0.0, 0.0
	for _, pos := range positions {
		xSum += float64(pos[0])
		ySum += float64(pos[1])
	}
	x, y := xSum/float64(n), ySum/float64(n)

	dist := func(x, y float64) float64 {
		res := 0.0
		for _, pos := range positions {
			dx := float64(pos[0]) - x
			dy := float64(pos[1]) - y
			res += math.Sqrt(dx*dx + dy*dy)
		}
		return res
	}

	alpha := 1.0
	for alpha > 1e-6 {
		nx, ny := x, y
		xSum, ySum := 0.0, 0.0
		wSum := 0.0
		for _, pos := range positions {
			dx := float64(pos[0]) - x
			dy := float64(pos[1]) - y
			d := math.Sqrt(dx*dx + dy*dy)
			if d == 0 {
				nx = float64(pos[0])
				ny = float64(pos[1])
				break
			}
			w := 1.0 / d
			xSum += float64(pos[0]) * w
			ySum += float64(pos[1]) * w
			wSum += w
		}
		if nx == x && ny == y {
			break
		}
		nx = xSum / wSum
		ny = ySum / wSum
		x = x + (nx-x)*alpha
		y = y + (ny-y)*alpha
		alpha *= 0.95
	}

	return dist(x, y)
}