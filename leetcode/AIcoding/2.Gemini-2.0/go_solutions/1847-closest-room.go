import (
	"sort"
)

func closestRoom(rooms [][]int, queries [][]int) []int {
	n := len(rooms)
	m := len(queries)
	res := make([]int, m)
	for i := range queries {
		queries[i] = append(queries[i], i)
	}
	sort.Slice(rooms, func(i, j int) bool {
		return rooms[i][1] > rooms[j][1]
	})
	sort.Slice(queries, func(i, j int) bool {
		return queries[i][1] > queries[j][1]
	})
	ids := []int{}
	j := 0
	for i := 0; i < m; i++ {
		minDiff := int(1e9 + 7)
		ans := -1
		sz := queries[i][1]
		for j < n && rooms[j][1] >= sz {
			ids = append(ids, rooms[j][0])
			j++
		}
		sort.Ints(ids)
		l, r := 0, len(ids)-1
		target := queries[i][0]
		for l <= r {
			mid := l + (r-l)/2
			diff := abs(ids[mid] - target)
			if diff < minDiff {
				minDiff = diff
				ans = ids[mid]
			} else if diff == minDiff {
				ans = min(ans, ids[mid])
			}
			if ids[mid] < target {
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
		res[queries[i][2]] = ans
	}
	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}