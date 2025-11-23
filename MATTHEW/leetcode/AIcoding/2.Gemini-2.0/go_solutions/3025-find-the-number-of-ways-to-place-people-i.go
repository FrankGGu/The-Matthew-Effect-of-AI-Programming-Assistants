import (
	"sort"
)

func numberOfWays(points [][]int) int {
	sort.Slice(points, func(i, j int) bool {
		if points[i][0] == points[j][0] {
			return points[i][1] < points[j][1]
		}
		return points[i][0] < points[j][0]
	})

	n := len(points)
	count := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			if points[j][0] >= points[i][0] && points[j][1] <= points[i][1] {
				valid := true
				for k := 0; k < n; k++ {
					if k == i || k == j {
						continue
					}
					if points[k][0] >= points[i][0] && points[k][0] <= points[j][0] && points[k][1] >= points[j][1] && points[k][1] <= points[i][1] {
						valid = false
						break
					}
				}
				if valid {
					count++
				}
			}
		}
	}
	return count
}