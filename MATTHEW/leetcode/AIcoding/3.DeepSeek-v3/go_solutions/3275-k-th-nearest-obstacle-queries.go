import (
	"sort"
)

func kthNearestObstacle(obstacles [][]int, queries [][]int) []int {
	obstacleMap := make(map[int][]int)
	for _, obs := range obstacles {
		x, y := obs[0], obs[1]
		obstacleMap[x] = append(obstacleMap[x], y)
	}

	for x := range obstacleMap {
		sort.Ints(obstacleMap[x])
	}

	res := make([]int, len(queries))
	for i, query := range queries {
		x, y, k := query[0], query[1], query[2]
		ys, exists := obstacleMap[x]
		if !exists {
			res[i] = -1
			continue
		}
		idx := sort.SearchInts(ys, y)
		left, right := idx-1, idx
		count := 0
		for count < k && (left >= 0 || right < len(ys)) {
			if left >= 0 && right < len(ys) {
				distLeft := y - ys[left]
				distRight := ys[right] - y
				if distLeft <= distRight {
					count++
					if count == k {
						res[i] = ys[left]
						break
					}
					left--
				} else {
					count++
					if count == k {
						res[i] = ys[right]
						break
					}
					right++
				}
			} else if left >= 0 {
				count++
				if count == k {
					res[i] = ys[left]
					break
				}
				left--
			} else {
				count++
				if count == k {
					res[i] = ys[right]
					break
				}
				right++
			}
		}
		if count < k {
			res[i] = -1
		}
	}
	return res
}