import (
	"math"
)

func numPoints(points [][]int, r int) int {
	n := len(points)
	ans := 1
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			x1, y1 := float64(points[i][0]), float64(points[i][1])
			x2, y2 := float64(points[j][0]), float64(points[j][1])
			dist := math.Sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
			if dist > 2*float64(r) {
				continue
			}
			midX := (x1 + x2) / 2
			midY := (y1 + y2) / 2
			d := math.Sqrt(float64(r*r) - (dist/2)*(dist/2))
			dx := (y1 - y2) * d / dist
			dy := (x2 - x1) * d / dist
			centerX1 := midX + dx
			centerY1 := midY + dy
			centerX2 := midX - dx
			centerY2 := midY - dy
			count1 := 0
			count2 := 0
			for k := 0; k < n; k++ {
				x, y := float64(points[k][0]), float64(points[k][1])
				dist1 := math.Sqrt((x-centerX1)*(x-centerX1) + (y-centerY1)*(y-centerY1))
				dist2 := math.Sqrt((x-centerX2)*(x-centerX2) + (y-centerY2)*(y-centerY2))
				if dist1 <= float64(r)+1e-6 {
					count1++
				}
				if dist2 <= float64(r)+1e-6 {
					count2++
				}
			}
			ans = max(ans, count1)
			ans = max(ans, count2)
		}
	}
	for i := 0; i < n; i++ {
		ans = max(ans, 1)
		count := 0
		for j := 0; j < n; j++ {
			x1, y1 := float64(points[i][0]), float64(points[i][1])
			x2, y2 := float64(points[j][0]), float64(points[j][1])
			dist := math.Sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
			if dist <= float64(r)+1e-6 {
				count++
			}
		}
		ans = max(ans, count)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}