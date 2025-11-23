import (
	"math"
	"sort"
)

func visiblePoints(points [][]int, angle int, location []int) int {
	same := 0
	angles := make([]float64, 0)
	x, y := location[0], location[1]
	for _, p := range points {
		px, py := p[0], p[1]
		if px == x && py == y {
			same++
			continue
		}
		theta := math.Atan2(float64(py-y), float64(px-x)) * 180 / math.Pi
		angles = append(angles, theta)
	}
	sort.Float64s(angles)
	n := len(angles)
	for i := 0; i < n; i++ {
		angles = append(angles, angles[i]+360)
	}
	max := 0
	right := 0
	for left := 0; left < n; left++ {
		for right < 2*n && angles[right]-angles[left] <= float64(angle)+1e-9 {
			right++
		}
		if right-left > max {
			max = right - left
		}
	}
	return max + same
}