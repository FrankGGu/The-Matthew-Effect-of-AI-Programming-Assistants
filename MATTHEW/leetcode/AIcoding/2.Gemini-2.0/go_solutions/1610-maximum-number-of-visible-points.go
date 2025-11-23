import (
	"math"
	"sort"
)

func visiblePoints(points [][]int, angle int, location []int) int {
	angles := []float64{}
	same := 0
	for _, point := range points {
		dx := point[0] - location[0]
		dy := point[1] - location[1]
		if dx == 0 && dy == 0 {
			same++
		} else {
			angles = append(angles, math.Atan2(float64(dy), float64(dx))*180/math.Pi)
		}
	}
	sort.Float64s(angles)
	n := len(angles)
	for i := 0; i < n; i++ {
		angles = append(angles, angles[i]+360)
	}
	maxPoints := 0
	left := 0
	for right := 0; right < len(angles); right++ {
		for angles[right]-angles[left] > float64(angle) {
			left++
		}
		maxPoints = max(maxPoints, right-left+1)
	}
	return maxPoints + same
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}