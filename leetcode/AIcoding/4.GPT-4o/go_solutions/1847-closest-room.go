import (
	"sort"
)

func closestRoom(rooms [][]int, queries [][]int) []int {
	n := len(rooms)
	m := len(queries)
	results := make([]int, m)

	type Query struct {
		index int
		id    int
	}
	queriesWithIndex := make([]Query, m)
	for i, q := range queries {
		queriesWithIndex[i] = Query{i, q[0]}
	}
	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i].id > queriesWithIndex[j].id
	})

	sort.Slice(rooms, func(i, j int) bool {
		return rooms[i][1] > rooms[j][1]
	})

	roomSet := make(map[int]bool)
	roomIndex := 0
	for i := 0; i < m; i++ {
		queryId := queriesWithIndex[i].id
		for roomIndex < n && rooms[roomIndex][0] <= queryId {
			roomSet[rooms[roomIndex][0]] = true
			roomIndex++
		}
		results[queriesWithIndex[i].index] = -1
		if len(roomSet) > 0 {
			best := -1
			bestDiff := 1<<30
			for roomId := range roomSet {
				if rooms[roomId][1]-queryId >= 0 && (queryId-rooms[roomId][0] < bestDiff) {
					bestDiff = queryId - rooms[roomId][0]
					best = rooms[roomId][0]
				}
			}
			results[queriesWithIndex[i].index] = best
		}
	}
	return results
}