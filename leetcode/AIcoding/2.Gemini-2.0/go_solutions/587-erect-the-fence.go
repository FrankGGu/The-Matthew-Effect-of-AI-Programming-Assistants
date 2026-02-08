import (
	"sort"
)

func outerTrees(points [][]int) [][]int {
	n := len(points)
	if n <= 3 {
		return points
	}

	sort.Slice(points, func(i, j int) bool {
		if points[i][0] == points[j][0] {
			return points[i][1] < points[j][1]
		}
		return points[i][0] < points[j][0]
	})

	hull := make([]int, 0)
	used := make([]bool, n)

	crossProduct := func(o, a, b []int) int {
		return (a[0]-o[0])*(b[1]-o[1]) - (a[1]-o[1])*(b[0]-o[0])
	}

	for i := 0; i < 2*n; i++ {
		k := i % n
		for len(hull) >= 2 && crossProduct(points[hull[len(hull)-2]], points[hull[len(hull)-1]], points[k]) < 0 {
			used[hull[len(hull)-1]] = false
			hull = hull[:len(hull)-1]
		}
		if !used[k] {
			hull = append(hull, k)
			used[k] = true
		}
	}

	result := make([][]int, 0)
	for _, i := range hull {
		result = append(result, points[i])
	}

	sort.Slice(result, func(i, j int) bool {
		if result[i][0] == result[j][0] {
			return result[i][1] < result[j][1]
		}
		return result[i][0] < result[j][0]
	})

	uniqueResult := make([][]int, 0)
	seen := make(map[[2]int]bool)
	for _, p := range result {
		key := [2]int{p[0], p[1]}
		if !seen[key] {
			uniqueResult = append(uniqueResult, p)
			seen[key] = true
		}
	}

	return uniqueResult
}