import (
	"sort"
)

func validSquare(p1 []int, p2 []int, p3 []int, p4 []int) bool {
	points := [][]int{p1, p2, p3, p4}
	distances := []int{}
	for i := 0; i < 4; i++ {
		for j := i + 1; j < 4; j++ {
			dist := (points[i][0]-points[j][0])*(points[i][0]-points[j][0]) + (points[i][1]-points[j][1])*(points[i][1]-points[j][1])
			if dist == 0 {
				return false
			}
			distances = append(distances, dist)
		}
	}
	sort.Ints(distances)
	return distances[0] == distances[1] && distances[1] == distances[2] && distances[2] == distances[3] && distances[4] == distances[5] && distances[0]*2 == distances[4]
}