import (
	"sort"
)

func kClosest(points [][]int, k int) [][]int {
	sort.Slice(points, func(i, j int) bool {
		distSqI := points[i][0]*points[i][0] + points[i][1]*points[i][1]
		distSqJ := points[j][0]*points[j][0] + points[j][1]*points[j][1]
		return distSqI < distSqJ
	})

	return points[:k]
}