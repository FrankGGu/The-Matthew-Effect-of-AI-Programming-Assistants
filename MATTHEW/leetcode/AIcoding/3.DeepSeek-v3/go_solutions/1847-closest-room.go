import (
	"sort"
)

type Room struct {
	id   int
	size int
}

func closestRoom(rooms [][]int, queries [][]int) []int {
	n := len(rooms)
	m := len(queries)
	roomList := make([]Room, n)
	for i := 0; i < n; i++ {
		roomList[i] = Room{rooms[i][0], rooms[i][1]}
	}
	sort.Slice(roomList, func(i, j int) bool {
		return roomList[i].size > roomList[j].size
	})

	queriesWithIndex := make([][3]int, m)
	for i := 0; i < m; i++ {
		queriesWithIndex[i] = [3]int{queries[i][0], queries[i][1], i}
	}
	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i][1] > queriesWithIndex[j][1]
	})

	res := make([]int, m)
	sortedIDs := []int{}
	ptr := 0

	for _, query := range queriesWithIndex {
		preferred, minSize, idx := query[0], query[1], query[2]
		for ptr < n && roomList[ptr].size >= minSize {
			insertPos := sort.Search(len(sortedIDs), func(i int) bool {
				return sortedIDs[i] >= roomList[ptr].id
			})
			sortedIDs = append(sortedIDs, 0)
			copy(sortedIDs[insertPos+1:], sortedIDs[insertPos:])
			sortedIDs[insertPos] = roomList[ptr].id
			ptr++
		}
		if len(sortedIDs) == 0 {
			res[idx] = -1
			continue
		}
		insertPos := sort.Search(len(sortedIDs), func(i int) bool {
			return sortedIDs[i] >= preferred
		})
		candidates := []int{}
		if insertPos > 0 {
			candidates = append(candidates, sortedIDs[insertPos-1])
		}
		if insertPos < len(sortedIDs) {
			candidates = append(candidates, sortedIDs[insertPos])
		}
		if len(candidates) == 0 {
			res[idx] = -1
		} else if len(candidates) == 1 {
			res[idx] = candidates[0]
		} else {
			diff1 := abs(candidates[0] - preferred)
			diff2 := abs(candidates[1] - preferred)
			if diff1 < diff2 {
				res[idx] = candidates[0]
			} else if diff1 > diff2 {
				res[idx] = candidates[1]
			} else {
				if candidates[0] < candidates[1] {
					res[idx] = candidates[0]
				} else {
					res[idx] = candidates[1]
				}
			}
		}
	}
	return res
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}