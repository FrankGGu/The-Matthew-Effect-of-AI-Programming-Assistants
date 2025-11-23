import (
	"sort"
)

func numberOfWays(points [][]int) int64 {
	n := len(points)
	sort.Slice(points, func(i, j int) bool {
		if points[i][0] == points[j][0] {
			return points[i][1] < points[j][1]
		}
		return points[i][0] < points[j][0]
	})

	count := int64(0)
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if i == j {
				continue
			}
			if points[i][0] <= points[j][0] && points[i][1] <= points[j][1] {
				valid := true
				for k := 0; k < n; k++ {
					if k == i || k == j {
						continue
					}
					if points[i][0] <= points[k][0] && points[k][0] <= points[j][0] && points[i][1] <= points[k][1] {
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