import (
	"sort"
)

func getDist(p1, p2 []int) int {
	return abs(p1[0]-p2[0]) + abs(p1[1]-p2[1])
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func visitOrder(points [][]int, start []int) []int {
	n := len(points)
	dists := make([]struct {
		idx  int
		dist int
	}, n)

	for i := 0; i < n; i++ {
		dists[i].idx = i
		dists[i].dist = getDist(start, points[i])
	}

	sort.Slice(dists, func(i, j int) bool {
		return dists[i].dist < dists[j].dist
	})

	result := make([]int, n)
	for i := 0; i < n; i++ {
		result[i] = dists[i].idx
	}

	return result
}